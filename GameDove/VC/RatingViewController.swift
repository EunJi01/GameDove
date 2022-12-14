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
        
        currentOrder = .rating
        fetchGames(platformID: currentPlatformID, order: currentOrder, baseDate: currentBaseDate)
        
        let sidemenu = UIBarButtonItem(image: IconSet.sideMenu, style: .plain, target: self, action: #selector(sideMenuTapped))
        let periodMenu = UIBarButtonItem(title: nil, image: IconSet.calendar, primaryAction: nil, menu: periodMenu())
        
        let searchButton = UIBarButtonItem(image: IconSet.search, style: .plain, target: self, action: #selector(presentSearch))
        let reloadButton = UIBarButtonItem(image: IconSet.reload, style: .plain, target: self, action: #selector(reloadButtonTapped))
        
        navigationItem.leftBarButtonItems = [sidemenu, periodMenu]
        navigationItem.rightBarButtonItems = [searchButton, reloadButton]
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
