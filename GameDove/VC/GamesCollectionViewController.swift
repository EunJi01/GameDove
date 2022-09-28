//
//  BaseCollectionViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/15.
//

import UIKit
import Kingfisher
import SnapKit
import JGProgressHUD

class GamesCollectionViewController: BaseViewController, GamesCollectionView {
    var games: [GameResults] = []
    let mainPlatform = MainPlatformRepository().fetch().first
    
    var currentPage = 1
    var currentBaseDate: String = defaultStartDate
    var currentOrder: APIQuery.Ordering!
    var currentSearch = ""
    var currentPeriod: APIPeriod = .all
    lazy var currentPlatformID: String = mainPlatform?.id ?? APIQuery.Platforms.nintendoSwitch.rawValue

    lazy var collectionView: UICollectionView = addCollectionView()
    lazy var reloadButton: UIButton = addReloadButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        reloadButton.addTarget(self, action: #selector(reloadButtonTapped), for: .touchUpInside)
    }
    
    @objc private func reloadButtonTapped() {
        fetchGames(platformID: currentPlatformID, order: currentOrder, baseDate: currentBaseDate)
        scrollToTop()
    }
    
    func fetchGames(platformID: String, order: APIQuery.Ordering, baseDate: String) {
        hud.show(in: view)

        GamesAPIManager.requestGames(order: order, platformID: platformID, baseDate: baseDate, search: currentSearch, page: "\(currentPage)") { [weak self] games, error in
            
            if let error = error {
                self?.errorAlert(error: error)
            }
            
            guard let games = games else { return }

            if self?.currentPlatformID == platformID && self?.currentBaseDate == baseDate {
                self?.games.append(contentsOf: games.results)
                self?.collectionView.reloadData()
            } else {
                self?.games = games.results
                self?.currentPlatformID = platformID
                self?.currentBaseDate = baseDate
                self?.collectionView.reloadData()
                self?.scrollToTop()
            }
            self?.hud.dismiss(animated: true)
            self?.navigationItem.title = APIQuery.Platforms(rawValue: platformID)?.title
        }
    }

    func filterPeriod(period: APIPeriod) {
        hud.show(in: view)
        
        GamesAPIManager.requestGames(order: currentOrder, platformID: currentPlatformID, baseDate: period.periodDate()) { [weak self] games, error in
            
            if let error = error {
                self?.errorAlert(error: error)
            }
            
            guard let items = self?.navigationItem.leftBarButtonItems else { return }
            items[1].tintColor = period == .all ? ColorSet.shared.button : .orange
            
            guard let games = games else { return }
            self?.currentBaseDate = period.periodDate()
            self?.games = games.results
            self?.collectionView.reloadData()
            self?.scrollToTop()
            self?.hud.dismiss(animated: true)
        }
    }
    
    @objc func platformMenu() -> UIMenu {
        var menuItems: [UIAction] = []

        for i in APIQuery.Platforms.allCases {
            let title = i.title
            menuItems.append(UIAction(title: title, image: nil, handler: { [weak self] _ in
                guard let self = self else { return }
                self.fetchGames(platformID: i.rawValue, order: self.currentOrder, baseDate: self.currentBaseDate)}))
        }
        
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        return menu
    }
    
    @objc func periodMenu() -> UIMenu {
        var menuItems: [UIAction] = []

        for i in 0...LocalizationKey.period.count - 1 {
            let period = APIPeriod.allCases[i]

            let image: UIImage? = period == currentPeriod ? IconSet.check : nil
            
            let title = LocalizationKey.period[i].localized
            menuItems.append(UIAction(title: title, image: image, handler: { [weak self] _ in
                self?.filterPeriod(period: period)
                self?.currentPeriod = period
                self?.resetMenu()
            }))
        }
        
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        return menu
    }
    
    private func resetMenu() {
        let platformMenu = UIBarButtonItem(title: nil, image: IconSet.platformList, primaryAction: nil, menu: platformMenu())
        let periodMenu = UIBarButtonItem(title: nil, image: IconSet.calendar, primaryAction: nil, menu: periodMenu())
        navigationItem.leftBarButtonItems = [platformMenu, periodMenu]
    }
    
    @objc func presentSearch() {
        let vc = SearchViewController()
        vc.currentOrder = currentOrder
        vc.currentPlatformID = currentPlatformID
        vc.currentBaseDate = currentBaseDate
        vc.navigationItem.title = APIQuery.Platforms(rawValue: currentPlatformID)?.title
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    func scrollToTop() {
        guard games.count > 0 else { return }
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}

extension GamesCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        vc.id = "\(games[indexPath.row].id)"
        vc.hidesBottomBarWhenPushed = true
        transition(vc, transitionStyle: .push)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCollectionViewCell.reuseIdentifier, for: indexPath) as? GamesCollectionViewCell else { return UICollectionViewCell() }
        
        cell.titleLabel.text = games[indexPath.row].name
        cell.releasedLabel.text = games[indexPath.row].released
        if let urlStr = games[indexPath.row].image {
            guard let url = URL(string: urlStr) else { return cell }
            KingfisherManager.shared.retrieveImage(with: url) { [weak self] result in
                switch result {
                case .success(let value):
                    let newImage = value.image.resize(newWidth: UIScreen.main.bounds.width)
                    cell.mainImageView.image = newImage
                case .failure(let error):
                    print("Error: \(error)")
                    self?.view.makeToast(LocalizationKey.failedImage.localized)
                }
            }
        }
            
        return cell
    }
}

extension GamesCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if (currentPage * 40 - 10) == indexPath.item {
                currentPage += 1
                print(currentPage)
                fetchGames(platformID: currentPlatformID, order: currentOrder, baseDate: currentBaseDate)
            }
            print("===\(indexPaths)")
        }
    }
}
