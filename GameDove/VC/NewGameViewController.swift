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
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: nil, image: IconSet.platformList, primaryAction: nil, menu: platformMenu())
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: IconSet.search, style: .plain, target: self, action: #selector(presentSearch))
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
