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
    
    var currentPlatform: APIQuery.Platforms = UserDefaults.standard.object(forKey: "mainPlatform") as? APIQuery.Platforms ?? .pc // 첫 화면 기본 플랫폼
    var currentPage = 1
    var currentBaseDate: String = defaultStartDate
    var currentOrder: APIQuery.Ordering!
    var currentSearch = ""
    
    lazy var collectionView: UICollectionView = addCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
    }
    
    func fetchGames(platform: APIQuery.Platforms, order: APIQuery.Ordering, baseDate: String) {
        hud.show(in: view)

        GamesAPIManager.requestGames(order: order, platform: platform, baseDate: baseDate, search: currentSearch, page: "\(currentPage)") { [weak self] games, error in
            guard let games = games else { return }

            if self?.currentPlatform == platform && self?.currentBaseDate == baseDate {
                self?.games.append(contentsOf: games.results)
                self?.collectionView.reloadData()
            } else {
                self?.games = games.results
                self?.currentPlatform = platform
                self?.currentBaseDate = baseDate
                self?.collectionView.reloadData()
                self?.scrollToTop()
            }
            self?.hud.dismiss(animated: true)
            self?.navigationItem.title = APIQuery.Platforms.title(platform: platform)
        }
    }

    func filterPeriod(period: APIPeriod) {
        hud.show(in: view)
        
        GamesAPIManager.requestGames(order: currentOrder, platform: currentPlatform, baseDate: period.periodDate()) { [weak self] games, error in
            guard let items = self?.navigationItem.leftBarButtonItems else { return }
            items[1].tintColor = period == .all ? ColorSet.shared.buttonColor : .red
            
            guard let games = games else { return }
            self?.currentBaseDate = period.periodDate()
            self?.games = games.results
            self?.scrollToTop()
            self?.collectionView.reloadData()
            self?.hud.dismiss(animated: true)
        }
    }
    
    @objc func platformMenu() -> UIMenu {
        var menuItems: [UIAction] = []
        
        //MARK: [weak self] 사용하기
        for i in APIQuery.Platforms.allCases {
            let title = APIQuery.Platforms.title(platform: i)
            menuItems.append(UIAction(title: title, image: nil, handler: { _ in self.fetchGames(platform: i, order: self.currentOrder, baseDate: self.currentBaseDate)}))
        }
        
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        return menu
    }
    
    @objc func presentSearch() {
        let vc = SearchViewController()
        vc.currentOrder = currentOrder
        vc.currentPlatform = currentPlatform
        vc.currentBaseDate = currentBaseDate
        vc.navigationItem.title = APIQuery.Platforms.title(platform: currentPlatform)
        transition(vc, transitionStyle: .presentFullNavigation)
    }
    
    func scrollToTop() { // 옵션 변경 시 뷰 최상단으로 이동
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
            let url = URL(string: urlStr)
            cell.mainImageView.kf.setImage(with: url)
        }
            
        return cell
    }
}

extension GamesCollectionViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        for indexPath in indexPaths {
            if (currentPage * 40 - 5) == indexPath.item {
                currentPage += 1
                print(currentPage)
                fetchGames(platform: currentPlatform, order: currentOrder, baseDate: currentBaseDate)
            }
            print("===\(indexPaths)")
        }
    }
}
