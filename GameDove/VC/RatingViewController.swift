//
//  RatingViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import UIKit
import Kingfisher

final class RatingViewController: BaseViewController {
    let mainView = GamesView()
    var games: Games?
    var currentPlatform: APIQuery.Platforms?
    var currentStartDate: String = defaultDate

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
    }
    
    override func configure() {
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        fetchGames(title: "Switch", platform: .nintendoSwitch)
        
        let platformMenu = UIBarButtonItem(title: nil, image: IconSet.platformList, primaryAction: nil, menu: platformMenu())
        let periodMenu = UIBarButtonItem(title: nil, image: IconSet.calendar, primaryAction: nil, menu: periodMenu())
        navigationItem.rightBarButtonItems = [platformMenu, periodMenu]
    }
    
    @objc private func periodMenu() -> UIMenu {
        let menuItems = [
            // MARK: 조금 더 깔끔하게 개선하면 좋을 것 같다... 예를들어... 반복문...?
            UIAction(title: LocalizationKey.week.localized, image: nil, handler: { _ in self.filterPeriod(period: .week)}),
            UIAction(title: LocalizationKey.month.localized, image: nil, handler: { _ in self.filterPeriod(period: .month)}),
            UIAction(title: LocalizationKey.halfYear.localized, image: nil, handler: { _ in self.filterPeriod(period: .halfYear)}),
            UIAction(title: LocalizationKey.year.localized, image: nil, handler: { _ in self.filterPeriod(period: .year)}),
            UIAction(title: LocalizationKey.years3.localized, image: nil, handler: { _ in self.filterPeriod(period: .years3)})
        ]
        
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        return menu
    }
    
    private func filterPeriod(period: Period) {
        guard let platform = currentPlatform else { return }
        
        GamesAPIManager.requestGames(order: .rating, platform: platform, startDate: period.periodDate()) { games, error in
            // MARK: 필터가 적용되는 동안 바버튼의 색을 바꾸고 싶다...!
            self.currentStartDate = period.periodDate()
            self.games = games
            self.mainView.collectionView.reloadData()
        }
    }
    
    @objc private func platformMenu() -> UIMenu {
        let menuItems = [
            UIAction(title: "PS5", image: nil, handler: { _ in self.fetchGames(title: "PS5", platform: .playStation5, startDate: self.currentStartDate)}),
            UIAction(title: "PS4", image: nil, handler: { _ in self.fetchGames(title: "PS4", platform: .playStation4, startDate: self.currentStartDate)}),
            UIAction(title: "Switch", image: nil, handler: { _ in self.fetchGames(title: "Switch", platform: .nintendoSwitch, startDate: self.currentStartDate)}),
            UIAction(title: "PC", image: nil, handler: { _ in self.fetchGames(title: "PC", platform: .pc, startDate: self.currentStartDate)}),
            UIAction(title: "iOS", image: nil, handler: { _ in self.fetchGames(title: "iOS", platform: .ios, startDate: self.currentStartDate)}),
            UIAction(title: "Android", image: nil, handler: { _ in self.fetchGames(title: "Android", platform: .android, startDate: self.currentStartDate)})
        ]
        
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        return menu
    }
    
    private func fetchGames(title: String, platform: APIQuery.Platforms, startDate: String = defaultDate) {
        GamesAPIManager.requestGames(order: .rating, platform: platform, startDate: startDate) { games, error in
            self.games = games
            self.currentPlatform = platform
            self.currentStartDate = startDate
            self.navigationItem.title = title
            self.mainView.collectionView.reloadData()
        }
    }
}

extension RatingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCollectionViewCell.reuseIdentifier, for: indexPath) as? GamesCollectionViewCell else { return UICollectionViewCell() }
        
        cell.titleLabel.text = games?.results[indexPath.row].name
        cell.releasedLabel.text = games?.results[indexPath.row].released
        if let urlStr = games?.results[indexPath.row].image {
            let url = URL(string: urlStr)
            cell.mainImageView.kf.setImage(with: url)
        }
        
        return cell
    }
}
