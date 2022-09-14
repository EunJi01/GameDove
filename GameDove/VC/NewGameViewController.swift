//
//  NewGameViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/08.
//

import UIKit
import Kingfisher

final class NewGameViewController: BaseViewController {
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
        mainView.collectionView.delegate = self
        mainView.collectionView.dataSource = self
        fetchGames(title: "Switch", platform: .nintendoSwitch)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: nil, image: IconSet.platformList, primaryAction: nil, menu: platformMenu())
    }
    
    @objc private func platformMenu() -> UIMenu {
        let menuItems = [
            UIAction(title: "PS5", image: nil, handler: { _ in self.fetchGames(title: "PS5", platform: .playStation5)}),
            UIAction(title: "PS4", image: nil, handler: { _ in self.fetchGames(title: "PS4", platform: .playStation4)}),
            UIAction(title: "Switch", image: nil, handler: { _ in self.fetchGames(title: "Switch", platform: .nintendoSwitch)}),
            UIAction(title: "PC", image: nil, handler: { _ in self.fetchGames(title: "PC", platform: .pc)}),
            UIAction(title: "iOS", image: nil, handler: { _ in self.fetchGames(title: "iOS", platform: .ios)}),
            UIAction(title: "Android", image: nil, handler: { _ in self.fetchGames(title: "Android", platform: .android)})
        ]
        
        let menu = UIMenu(title: "", image: nil, identifier: nil, options: [], children: menuItems)
        return menu
    }
    
    private func fetchGames(title: String, platform: APIQuery.Platforms) {
        GamesAPIManager.requestGames(order: .released, platform: platform, startDate: defaultDate) { games, error in
            self.games = games
            self.navigationItem.title = title
            self.mainView.collectionView.reloadData()
            //dump(games)
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
