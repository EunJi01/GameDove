//
//  DetailViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/13.
//

import UIKit
import Kingfisher
import Toast
import JGProgressHUD

final class DetailsViewController: BaseViewController {
    let mainView = DetailsView()
    let repository = StorageRepository()
    
    var id: String?
    var details: Details?
    var mainImage: String?
    var scList: [String] = []
    var imageList: [UIImage] = []
    var timer: Timer?
    
    var nowPage = 0 {
        didSet {
            mainView.pagingIndexLabel.text = "\(nowPage + 1) / \(scList.count + 1)"
        }
    }

    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchDetails()
        print("id : " + id!)
        print("Realm is located at:", repository.localRealm.configuration.fileURL!)
    }
    
    override func configure() {
        mainView.bannerCollectionView.delegate = self
        mainView.bannerCollectionView.dataSource = self
        mainView.detailsCollectionView.delegate = self
        mainView.detailsCollectionView.dataSource = self

        let trayButton = UIBarButtonItem(image: IconSet.trayDown, style: .plain, target: self, action: #selector(trayTapped))
        let shareButton = UIBarButtonItem(image: IconSet.share, style: .plain, target: self, action: #selector(shareButtonTapped))
        navigationItem.rightBarButtonItems = [trayButton, shareButton]
    }
    
    @objc private func shareButtonTapped() {
        guard let details = details,
              let mainImage = mainImage,
              let url = URL(string: mainImage) else {
            return
        }
        
        var image: UIImage?

        KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
            switch result {
            case .success(let value):
                image = value.image.resize(newWidth: UIScreen.main.bounds.width)
            case .failure(let error):
                print("Error: \(error)")
                self?.view.makeToast(LocalizationKey.failedImage.localized)
            }
        }
        
        let title = LocalizationKey.title.localized + " : " + details.name
        let released = LocalizationKey.released.localized + " : " + details.released
        let app = "- " + "CFBundleDisplayName".localized
        let activityVC = UIActivityViewController(activityItems: [image ?? "", title, released, app],
                                                  applicationActivities: nil)
        activityVC.excludedActivityTypes = [.mail, .markupAsPDF, .assignToContact]
        self.present(activityVC, animated: true)
    }
    
    @objc private func trayTapped() {
        do {
            try repository.localRealm.write {
                guard let details = details else { return }
                if repository.canStore(id: details.id) {
                    let newTask = Storage(id: details.id, title: details.name, released: details.released)
                    repository.localRealm.add(newTask)
                    view.makeToast(LocalizationKey.stored.localized)
                } else {
                    view.makeToast(LocalizationKey.failedStore.localized)
                }
            }
        } catch let error {
            print(error)
        }
    }
    
    private func fetchDetails() {
        guard let id = id else { return }
        let group = DispatchGroup()
        
        hud.show(in: view)
        
        group.enter()
        DetailsAPIManager.requestDetails(id: id, sc: false) { [weak self] details, _, error in
            if let error = error {
                self?.errorAlert(error: error)
            } else {
                self?.details = details
                self?.mainImage = details?.image
                self?.mainView.titleLabel.text = details?.name
            }
            group.leave()
        }

        group.enter()
        DetailsAPIManager.requestDetails(id: id, sc: true) { [weak self] _, sc, error in
            if let error = error {
                self?.errorAlert(error: error)
            } else if let sc = sc {
                self?.scList = sc.results.map { $0.image }
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.scList.removeAll(where: { $0 == self?.mainImage })
            self?.hud.dismiss(animated: true)
            self?.mainView.pagingIndexLabel.text = "1 / \((self?.scList.count ?? 0) + 1)"
            self?.mainView.bannerCollectionView.reloadData()
            self?.mainView.detailsCollectionView.reloadData()
            self?.bannerTimer()
            self?.fetchImage()
        }
    }
    
    private func fetchImage() {
        scList.forEach {
            guard let url = URL(string: $0) else { return }
            KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
                switch result {
                case .success(let value):
                    let newImage = value.image.resize(newWidth: UIScreen.main.bounds.width)
                    self?.imageList.append(newImage)
                case .failure(_):
                    self?.view.makeToast(LocalizationKey.failedImage.localized)
                }
            }
        }
    }
    
    private func bannerTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] Timer in
            self?.bannerMove()
            print(#function)
        }
    }

    private func bannerMove() {
        if nowPage == scList.count {
            mainView.bannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: false)
            nowPage = 0
            return
        }
        nowPage += 1
        mainView.bannerCollectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
    deinit {
        timer?.invalidate()
    }
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == mainView.bannerCollectionView ? scList.count + 1 : DetailsItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainView.bannerCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.reuseIdentifier, for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            if indexPath.row == 0 {
                if let mainImage = mainImage {
                    let url = URL(string: mainImage)
                    cell.bannerImageView.kf.setImage(with: url)
                }
            } else if imageList.count >= indexPath.row {
                cell.bannerImageView.image = imageList[indexPath.row - 1]
            }
            return cell
            
        case mainView.detailsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailsCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.itemLabel.text = DetailsItem.allCases[indexPath.row].title()
            
            guard let data = details else { return cell }
            cell.itemDataLabel.text = DetailsItem.allCases[indexPath.row].itemData(details: data)
            cell.contentView.widthAnchor.constraint(equalToConstant: mainView.width).isActive = true
            cell.itemLabel.textColor = ColorSet.shared.button
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        guard scrollView == mainView.bannerCollectionView else { return }
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
        timer?.invalidate()
        bannerTimer()
    }
}
