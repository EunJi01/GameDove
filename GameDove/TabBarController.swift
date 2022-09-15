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
 //       let thirdNav = UINavigationController(rootViewController: SearchViewController())
        
        firstNav.tabBarItem = UITabBarItem(title: LocalizationKey.newGame.localized, image: TabBarIconSet.newly, selectedImage: TabBarIconSet.newlySelected)
        secondNav.tabBarItem = UITabBarItem(title: LocalizationKey.popularGame.localized, image: TabBarIconSet.rating, selectedImage: TabBarIconSet.ratingSelected)
 //       thirdNav.tabBarItem = UITabBarItem(title: LocalizationKey.searchGame.localized, image: TabBarIconSet.search, selectedImage: TabBarIconSet.searchSelected)


        setViewControllers([firstNav, secondNav], animated: true)
        hidesBottomBarWhenPushed = true // 네비게이션VC로 푸쉬했을 때 밑에 바가 사라지는 것
        tabBar.tintColor = ColorSet.shared.buttonColor
    }
}
