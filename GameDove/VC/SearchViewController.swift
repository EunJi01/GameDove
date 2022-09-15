//
//  SearchViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/13.
//

import UIKit
import SnapKit

final class SearchViewController: GamesCollectionViewController {
    
    private let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = LocalizationKey.searchPlaceholder.localized
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        [searchBar, collectionView].forEach {
            view.addSubview($0)
        }
        
        currentOrder = .metacritic
        tapGesture()
        searchBar.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: IconSet.xmark, style: .plain, target: self, action: #selector(dismissView))
    }
    
    override func setConstraints() {
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(44)
        }
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalTo(view)
        }
    }

    @objc private func dismissView() {
        dismiss(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        GamesAPIManager.requestGames(order: currentOrder, platform: nil, startDate: defaultDate, search: text) { games, error in
            guard let games = games else { return }
            self.games.append(contentsOf: games.results)
            self.collectionView.reloadData()
        }
    }
}
