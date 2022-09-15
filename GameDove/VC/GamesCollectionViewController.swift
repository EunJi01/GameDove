//
//  BaseCollectionViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/15.
//

import UIKit
import Kingfisher
import SnapKit

class GamesCollectionViewController: BaseViewController, GamesCollectionView {
    var games: [GameResults] = []
    var currentPlatform: APIQuery.Platforms = .nintendoSwitch // 첫 화면 기본 플랫폼
    var currentPage = 1
    var currentStartDate: String = defaultDate
    var currentOrder: APIQuery.Ordering!
    
    lazy var collectionView: UICollectionView = addCollectionView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }
    
    func fetchGames(platform: APIQuery.Platforms, order: APIQuery.Ordering, startDate: String) {
        GamesAPIManager.requestGames(order: order, platform: platform, startDate: currentStartDate, page: "\(currentPage)") { games, error in
            guard let games = games else { return }
            
            if self.currentPlatform == platform && self.currentStartDate == startDate {
                self.games.append(contentsOf: games.results)
            } else {
                self.games = games.results
                self.currentPlatform = platform
                self.currentStartDate = startDate
                self.scrollToTop()
            }
            self.navigationItem.title = APIQuery.Platforms.title(platform: platform)
            self.collectionView.reloadData()
        }
    }

//    private func filterPeriod(period: APIPeriod) {
//        guard let platform = currentPlatform else { return }
//
//        GamesAPIManager.requestGames(order: .rating, platform: platform, startDate: period.periodDate()) { games, error in
//            guard let items = self.navigationItem.leftBarButtonItems else { return }
//            items[1].tintColor = period == .all ? ColorSet.shared.buttonColor : .red
//            
//            guard let games = games else { return }
//            self.currentStartDate = period.periodDate()
//            self.games.append(contentsOf: games.results)
//            self.mainView.collectionView.reloadData()
//        }
//    }
    
    @objc func platformMenu() -> UIMenu {
        var menuItems: [UIAction] = []
        
        for i in APIQuery.Platforms.allCases {
            let title = APIQuery.Platforms.title(platform: i)
            menuItems.append(UIAction(title: title, image: nil, handler: { _ in self.fetchGames(platform: i, order: self.currentOrder, startDate: self.currentStartDate)}))
        }
        
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        return menu
    }
    
    @objc func presentSearch() {
        transition(SearchViewController(), transitionStyle: .presentFullNavigation)
    }
    
    func scrollToTop() { // 옵션 변경 시 뷰 최상단으로 이동 (새로고침 버튼 등 응용 가능)
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
    }
}

extension GamesCollectionViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
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
                fetchGames(platform: currentPlatform, order: currentOrder, startDate: currentStartDate)
            }
            print("===\(indexPaths)")
        }
    }
}

// MARK: 로딩 중 애니메이션 넣기 (나중에...)
//extension NewGameViewController: SkeletonCollectionViewDelegate, SkeletonCollectionViewDataSource {
//    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
//        return GamesCollectionViewCell.reuseIdentifier
//    }
//
//    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 3
//    }
//}
