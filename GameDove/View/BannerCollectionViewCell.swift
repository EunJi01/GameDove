//
//  DetailsCollectionViewCell.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/13.
//

import UIKit
import SnapKit

class BannerCollectionViewCell: UICollectionViewCell {
    let bannerImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ColorSet.shared.gray
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
    
    private func configure() {
        addSubview(bannerImageView)
    }

    private func setConstraints() {
        bannerImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
