//
//  UpcomingGameViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/16.
//

import UIKit

final class UpcomingGameViewController: GamesCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        view.addSubview(collectionView)
        
        currentOrder = .upcoming
        fetchGames(platformID: currentPlatformID, order: currentOrder, baseDate: defaultEndDate)
        
        let sidemenu = UIBarButtonItem(image: IconSet.sideMenu, style: .plain, target: self, action: #selector(sideMenuTapped))
        let searchButton = UIBarButtonItem(image: IconSet.search, style: .plain, target: self, action: #selector(presentSearch))
        let reloadButton = UIBarButtonItem(image: IconSet.reload, style: .plain, target: self, action: #selector(reloadButtonTapped))
        
        navigationItem.leftBarButtonItems = [sidemenu]
        navigationItem.rightBarButtonItems = [searchButton, reloadButton]
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
