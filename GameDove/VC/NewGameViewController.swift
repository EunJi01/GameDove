//
//  NewGameViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/08.
//

import UIKit

final class NewGameViewController: GamesCollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        view.addSubview(collectionView)
        
        currentOrder = .released
        fetchGames(platformID: currentPlatformID, order: currentOrder, baseDate: currentBaseDate)
        
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
