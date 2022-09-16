//
//  SearchViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/13.
//

import UIKit
import SnapKit

final class SearchViewController: GamesCollectionViewController {
    
    private lazy var searchBar: UISearchBar = {
        let view = UISearchBar()
        var order = ""
        
        switch currentOrder {
        case .metacritic:
            order = LocalizationKey.popularGames.localized
        case .released:
            order = LocalizationKey.newGames.localized
        case .upcoming:
            order = LocalizationKey.upcomingGames.localized
        case .none:
            break
        }
        
        view.placeholder = LocalizationKey.searchPlaceholder.localized(with: order.lowercased())
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        [searchBar, collectionView].forEach {
            view.addSubview($0)
        }

        tapGesture()
        searchBar.delegate = self
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: IconSet.xmark, style: .plain, target: self, action: #selector(dismissView))
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
        
        GamesAPIManager.requestGames(order: currentOrder, platform: currentPlatform, baseDate: currentBaseDate, search: text) { games, error in
            guard let games = games else { return }
            
            self.currentSearch = text
            self.games = games.results
            self.collectionView.reloadData()
            self.scrollToTop()
        }
    }
}
