//
//  TabBarController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/08.
//

import UIKit

final class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configureTabBarController()
    }

    private func configureTabBarController() {
        let firstNav = UINavigationController(rootViewController: NewGameViewController())
        let secondNav = UINavigationController(rootViewController: RatingViewController())
        let thirdNav = UINavigationController(rootViewController: UpcomingGameViewController())
        let fourthNav = UINavigationController(rootViewController: StorageViewController())
        let fifthNav = UINavigationController(rootViewController: SettingsViewController())
        
        firstNav.tabBarItem = UITabBarItem(title: LocalizationKey.newGames.localized, image: TabBarIconSet.newly, selectedImage: TabBarIconSet.newlySelected)
        secondNav.tabBarItem = UITabBarItem(title: LocalizationKey.popularGames.localized, image: TabBarIconSet.rating, selectedImage: TabBarIconSet.ratingSelected)
        thirdNav.tabBarItem = UITabBarItem(title: LocalizationKey.upcomingGames.localized, image: TabBarIconSet.upcoming, selectedImage: TabBarIconSet.upcomingSelected)
        fourthNav.tabBarItem = UITabBarItem(title: LocalizationKey.storage.localized, image: TabBarIconSet.tray, selectedImage: TabBarIconSet.traySelected)
        fifthNav.tabBarItem = UITabBarItem(title: LocalizationKey.settings.localized, image: TabBarIconSet.setting, selectedImage: TabBarIconSet.settingSelected)

        setViewControllers([secondNav, firstNav, thirdNav, fourthNav, fifthNav], animated: true)
        hidesBottomBarWhenPushed = true // 네비게이션VC로 푸쉬했을 때 밑에 바가 사라지는 것
        tabBar.tintColor = ColorSet.shared.button
    }
}
