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
//        let thirdVC = SettingViewController()

        firstNav.tabBarItem = UITabBarItem(title: "인기작", image: TabBarIconSet.rating, selectedImage: TabBarIconSet.ratingSelected)
        secondNav.tabBarItem = UITabBarItem(title: "신작", image: TabBarIconSet.newly, selectedImage: TabBarIconSet.newlySelected)

        setViewControllers([firstNav, secondNav], animated: true)
        hidesBottomBarWhenPushed = false // 네비게이션VC로 푸쉬했을 때 밑에 바가 사라지는 것을 방지
        tabBar.tintColor = ColorSet.shared.buttonColor
    }
}
