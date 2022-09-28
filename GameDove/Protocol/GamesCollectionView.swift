//
//  GamesCollectionView.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/15.
//

import UIKit

protocol GamesCollectionView {
    func addCollectionView() -> UICollectionView
    func addReloadButton() -> UIButton
}

extension GamesCollectionView where Self: UICollectionViewDataSource, Self: UICollectionViewDelegate, Self: UICollectionViewDataSourcePrefetching {
    
    func addCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 300)
        
        let gamesCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        gamesCollectionView.backgroundColor = ColorSet.shared.background
        gamesCollectionView.dataSource = self
        gamesCollectionView.delegate = self
        gamesCollectionView.prefetchDataSource = self
        gamesCollectionView.register(GamesCollectionViewCell.self, forCellWithReuseIdentifier: GamesCollectionViewCell.reuseIdentifier)
        
        return gamesCollectionView
    }
    
    func addReloadButton() -> UIButton {
        let reloadButton = UIButton()
        reloadButton.tintColor = ColorSet.shared.background
        reloadButton.setImage(IconSet.reload, for: .normal)
        reloadButton.contentMode = .scaleAspectFit
        reloadButton.contentHorizontalAlignment = .fill
        reloadButton.contentVerticalAlignment = .fill
        reloadButton.backgroundColor = ColorSet.shared.button
        reloadButton.layer.cornerRadius = 22
        return reloadButton
    }
}
