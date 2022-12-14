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
        case .rating:
            order = LocalizationKey.popularGames.localized
        case .released:
            order = LocalizationKey.newGames.localized
        case .upcoming:
            order = LocalizationKey.upcomingGames.localized
        case .metascore:
            order = LocalizationKey.metascore.localized
        case .none:
            break
        }
        
        view.barTintColor = ColorSet.shared.background
        view.placeholder = LocalizationKey.searchPlaceholder.localized(with: order.lowercased())
        return view
    }()
    
    private let noResultsLabel: UILabel = {
        let view = UILabel()
        view.text = LocalizationKey.noResults.localized
        view.textColor = ColorSet.shared.gray
        view.isHidden = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tapGesture()
        currentSearch = "검색"
        platformButton.setImage(IconSet.down, for: .normal)
        platformButton.setTitle(APIQuery.Platforms(rawValue: currentPlatformID)?.title, for: .normal)
    }
    
    override func configure() {
        [searchBar, collectionView, noResultsLabel].forEach {
            view.addSubview($0)
        }
    
        searchBar.delegate = self
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: IconSet.xmark, style: .plain, target: self, action: #selector(dismissView))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: IconSet.reload, style: .plain, target: self, action: #selector(reloadButtonTapped))
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
        
        print("===현재 요청하는 오더: \(currentOrder!)")
        print("===현재 요청하는 플랫폼: \(APIQuery.Platforms(rawValue: currentPlatformID)?.title ?? "없음")")
        
        hud.show(in: view)
        
        GamesAPIManager.requestGames(order: currentOrder, platformID: currentPlatformID, baseDate: currentBaseDate, search: text) { [weak self] games, error in
            
            if let error = error {
                self?.errorAlert(error: error)
                self?.hud.dismiss(animated: true)
            }
            
            guard let games = games else { return }
            
            self?.currentSearch = text
            self?.games = games.results
            self?.collectionView.reloadData()
            self?.scrollToTop()
            self?.hud.dismiss(animated: true)
            
            self?.noResultsLabel.isHidden = (self?.games.isEmpty ?? false) ? false : true
        }
        view.endEditing(true)
    }
}
