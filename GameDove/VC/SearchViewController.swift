//
//  SearchViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/13.
//

import UIKit

class SearchViewController: BaseViewController {
    let mainView = SearchView()
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
        mainView.searchBar.delegate = self
    }
}

extension SearchViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        GamesAPIManager.requestGames(order: <#T##APIQuery.Ordering#>, platform: <#T##APIQuery.Platforms#>, startDate: <#T##String#>, completion: <#T##(Games?, APIError?) -> Void#>)
//    }
}

extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
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
