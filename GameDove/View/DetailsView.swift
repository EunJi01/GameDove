//
//  DetailView.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/13.
//

import UIKit
import SnapKit

class DetailsView: UIView {
    let width = UIScreen.main.bounds.width
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 30)
        view.adjustsFontSizeToFitWidth = true
        view.textColor = ColorSet.shared.buttonColor
        return view
    }()

    lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: width, height: width * 0.55)
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.reuseIdentifier)
        view.isPagingEnabled = true
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear

        return view
    }()
    
    let pagingIndexView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorSet.shared.clearBlack
        view.layer.cornerRadius = 10
        return view
    }()
    
    let pagingIndexLabel: UILabel = {
        let view = UILabel()
        view.textColor = .white
        view.font = .systemFont(ofSize: 12)
        return view
    }()
    
    lazy var detailsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 10
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(DetailsCollectionViewCell.self, forCellWithReuseIdentifier: DetailsCollectionViewCell.reuseIdentifier)
        view.backgroundColor = .clear
        
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        [titleLabel, bannerCollectionView, pagingIndexView, pagingIndexLabel, detailsCollectionView].forEach {
            addSubview($0)
        }
    }

    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(14)
        }
        
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(UIScreen.main.bounds.width * 0.6)
        }

        pagingIndexView.snp.makeConstraints { make in
            make.trailing.equalTo(bannerCollectionView.snp.trailing).inset(12)
            make.bottom.equalTo(bannerCollectionView.snp.bottom).inset(22)
            make.height.equalTo(20)
            make.width.equalTo(50)
        }
        
        pagingIndexLabel.snp.makeConstraints { make in
            make.center.equalTo(pagingIndexView.snp.center)
        }
        
        detailsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(bannerCollectionView.snp.bottom)
            make.bottom.equalToSuperview()
            make.horizontalEdges.bottom.equalToSuperview()
        }
    }
}
