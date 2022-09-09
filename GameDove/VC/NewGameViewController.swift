//
//  NewGameViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/08.
//

import UIKit
import Kingfisher

class NewGameViewController: BaseViewController {
    let mainView = GamesView()
    var games: Games?

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = .white
    }
    
    override func configure() {
        fetchGames()
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
    }
    
    @objc func menu() -> UIMenu {
        let menuItems = [
            UIAction(title: "PS5", image: nil, handler: { _ in }),
            UIAction(title: "PS4", image: nil, handler: { _ in }),
            UIAction(title: "Nintendo-Switch", image: nil, handler: { _ in }),
            UIAction(title: "PC", image: nil, handler: { _ in }),
            UIAction(title: "iOS", image: nil, handler: { _ in }),
            UIAction(title: "Android", image: nil, handler: { _ in })
        ]
        
        let menu = UIMenu(title: "플랫폼 선택(임시)", image: nil, identifier: nil, options: [], children: menuItems)
        return menu
    }
    
    func fetchGames() {
        GamesAPIManager.requestGames(order: .metacritic, platform: .nintendoSwitch) { games, error in
            self.games = games
            self.mainView.collectionView.reloadData()
        }
    }
}

extension NewGameViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return games?.results.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GamesCollectionViewCell.reuseIdentifier, for: indexPath) as? GamesCollectionViewCell else { return UICollectionViewCell() }
        
        cell.titleLabel.text = games?.results[indexPath.row].name
        cell.releasedLabel.text = games?.results[indexPath.row].released
        if let urlStr = games?.results[indexPath.row].image {
            let url = URL(string: urlStr)
            cell.mainImageView.kf.setImage(with: url)
        }
        
        return cell
    }
}
