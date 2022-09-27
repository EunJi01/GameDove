//
//  RatingViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import UIKit

final class RatingViewController: GamesCollectionViewController {
    var currentPeriod: APIPeriod = .all
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func configure() {
        view.addSubview(collectionView)
        currentOrder = .metacritic
        fetchGames(platformID: currentPlatformID, order: currentOrder, baseDate: currentBaseDate)
        
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

        for i in 0...LocalizationKey.period.count - 1 {
            let period = APIPeriod.allCases[i]

            let image: UIImage? = period == currentPeriod ? IconSet.check : nil
            
            let title = LocalizationKey.period[i].localized
            menuItems.append(UIAction(title: title, image: image, handler: { _ in
                self.filterPeriod(period: period)
                self.currentPeriod = period
                self.resetMenu()
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
}
