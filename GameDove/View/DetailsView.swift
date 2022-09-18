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
        view.font = .boldSystemFont(ofSize: 26)
        view.adjustsFontSizeToFitWidth = true
        view.minimumScaleFactor = 0.5
        view.textColor = ColorSet.shared.buttonColor
        return view
    }()

    lazy var bannerCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: width, height: width * 0.55)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0

        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.register(BannerCollectionViewCell.self, forCellWithReuseIdentifier: BannerCollectionViewCell.reuseIdentifier)
        view.isPagingEnabled = true
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
    
    lazy var detailsTableView: UITableView = {
        let view = UITableView()
        // MARK: 여기다가 뭐 막 장르 이런거 나열할거임
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
        [titleLabel, bannerCollectionView, pagingIndexView, detailsTableView].forEach {
            addSubview($0)
        }

        pagingIndexView.addSubview(pagingIndexLabel)
    }
    
    func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview().inset(14)
        }
        
        bannerCollectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(width * 0.6)
        }
        
        pagingIndexLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        pagingIndexView.snp.makeConstraints { make in
            make.horizontalEdges.equalTo(pagingIndexLabel).inset(-10)
            make.verticalEdges.equalTo(pagingIndexLabel).inset(-4)
            make.trailing.equalTo(bannerCollectionView).inset(12)
            make.bottom.equalTo(bannerCollectionView).inset(22)
        }
    }
}
