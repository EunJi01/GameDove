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
    
    private let noResultsLabel: UILabel = {
        let view = UILabel()
        view.text = "검색 결과 없음"
        view.textColor = .lightGray
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        [searchBar, collectionView, noResultsLabel].forEach {
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
        
        noResultsLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }

    @objc private func dismissView() {
        dismiss(animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        
        // MARK: 검색했을 때 간혈적으로 원하는 order로 나오지 않는 버그 있음ㅠㅠ
        print("===현재 요청하는 order: \(currentOrder!)")
        
        hud.show(in: view)
        
        GamesAPIManager.requestGames(order: currentOrder, platform: currentPlatform, baseDate: currentBaseDate, search: text) { [weak self] games, error in
            guard let games = games else { return }
            
            self?.currentSearch = text
            self?.games = games.results
            self?.collectionView.reloadData()
            self?.scrollToTop()
            self?.hud.dismiss(animated: true)
            
            self?.noResultsLabel.isHidden = (self?.games.isEmpty ?? false) ? false : true
        }
    }
}
