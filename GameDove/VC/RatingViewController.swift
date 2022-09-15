//
//  RatingViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import UIKit

final class RatingViewController: GamesCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configure() {
        view.addSubview(collectionView)
        currentOrder = .metacritic
        fetchGames(platform: currentPlatform, order: .metacritic, startDate: currentStartDate)
        
        let platformMenu = UIBarButtonItem(title: nil, image: IconSet.platformList, primaryAction: nil, menu: platformMenu())
        let periodMenu = UIBarButtonItem(title: nil, image: IconSet.calendar, primaryAction: nil, menu: periodMenu())
        navigationItem.leftBarButtonItems = [platformMenu, periodMenu]
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: IconSet.search, style: .plain, target: self, action: #selector(presentSearch))
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func periodMenu() -> UIMenu {
        var menuItems: [UIAction] = []
        
        // MARK: 제대로 현지화 대응하기
        for i in 0...LocalizationKey.period.count - 1 {
            let title = LocalizationKey.period[i]
            let period = APIPeriod.allCases[i]
            //menuItems.append(UIAction(title: title, image: nil, handler: { _ in self.filterPeriod(period: period)}))
        }
        
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        return menu
    }
}
