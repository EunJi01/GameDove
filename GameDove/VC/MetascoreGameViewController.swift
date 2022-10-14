//
//  MetascoreGameViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/10/15.
//

import UIKit

final class MetascoreGameViewController: GamesCollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configure() {
        view.addSubview(collectionView)
        
        currentOrder = .metascore
        fetchGames(platformID: currentPlatformID, order: currentOrder, baseDate: currentBaseDate)
        
        let reloadButton = UIBarButtonItem(image: IconSet.reload, style: .plain, target: self, action: #selector(reloadButtonTapped))
        
        navigationItem.rightBarButtonItems = [reloadButton]
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
