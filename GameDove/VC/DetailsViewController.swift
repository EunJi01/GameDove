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

class DetailsViewController: BaseViewController {
    let mainView = DetailsView()
    
    var id: String?
    var details: Details?
    var mainImage: String?
    var scList: [ScreenshotsResults] = []
    
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
    }
    
    override func configure() {
        mainView.bannerCollectionView.delegate = self
        mainView.bannerCollectionView.dataSource = self
        mainView.detailsCollectionView.delegate = self
        mainView.detailsCollectionView.dataSource = self

        navigationItem.rightBarButtonItem = UIBarButtonItem(image: TabBarIconSet.archivebox, style: .plain, target: self, action: #selector(archiveboxTapped))
    }
    
    @objc private func archiveboxTapped() {
        view.makeToast(LocalizationKey.saved.localized)
    }
    
    private func fetchDetails() {
        guard let id = id else { return }
        let group = DispatchGroup()
        
        hud.show(in: view)
        
        group.enter()
        DetailsAPIManager.requestDetails(id: id, sc: false) { [weak self] details, non, error in
            self?.details = details
            self?.mainImage = details?.image
            self?.mainView.titleLabel.text = details?.name
            group.leave()
        }

        group.enter()
        DetailsAPIManager.requestDetails(id: id, sc: true) { [weak self] non, sc, error in
            if let sc = sc {
                self?.scList = sc.results
            }
            group.leave()
        }
        
        group.notify(queue: .main) { [weak self] in
            self?.hud.dismiss(animated: true)
            self?.mainView.pagingIndexLabel.text = "1 / \((self?.scList.count ?? 0) + 1)"
            self?.mainView.bannerCollectionView.reloadData()
            self?.mainView.detailsCollectionView.reloadData()
            self?.bannerTimer()
        }
    }
    
    private func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 3, repeats: true) { [weak self] Timer in
            self?.bannerMove()
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
}

extension DetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionView == mainView.bannerCollectionView ? scList.count + 1 : DetailsItem.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case mainView.bannerCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BannerCollectionViewCell.reuseIdentifier, for: indexPath) as? BannerCollectionViewCell else {
                return UICollectionViewCell()
            }
            
            switch indexPath.row {
            case 0:
                if let mainImage = mainImage {
                    let url = URL(string: mainImage)
                    cell.bannerImageView.kf.setImage(with: url)
                }
            default:
                if !(scList.isEmpty) {
                    let url = URL(string: scList[indexPath.row - 1].image)
                    cell.bannerImageView.kf.setImage(with: url)
                }
            }
            return cell
            
        case mainView.detailsCollectionView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailsCollectionViewCell else {
                return UICollectionViewCell()
            }

            cell.itemLabel.text = DetailsItem.allCases[indexPath.row].title()

            guard let data = details else { return cell }
            cell.itemDataLabel.text = DetailsItem.allCases[indexPath.row].itemData(details: data)
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width

        switch collectionView {
        case mainView.bannerCollectionView:
            return CGSize(width: width, height: width * 0.55)

        case mainView.detailsCollectionView:
            //guard let data = details else { return CGSize(width: width, height: 50) }
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DetailsCollectionViewCell.reuseIdentifier, for: indexPath) as? DetailsCollectionViewCell else {
                return .zero
            }
            let height = cell.itemDataLabel.frame.height + 40
            return CGSize(width: width, height: height)
            
        default:
            return .zero
        }
    }
}
