//
//  RatingViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/09.
//

import UIKit

class RatingViewController: BaseViewController {
    let mainView = GamesView()
    var games: Games?
    
    override func loadView() {
        view = mainView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func configure() {
        //fetchGames()
        
    }
    
    func fetchGames() {
        GamesAPIManager.requestGames(order: .metacritic, platform: .nintendoSwitch) { games, error in
            //dump(games)
            self.games = games
            self.mainView.collectionView.reloadData()
        }
    }
}
