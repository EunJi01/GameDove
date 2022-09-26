//
//  DetailsCollectionViewCell.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/18.
//

import UIKit
import SnapKit

class DetailsCollectionViewCell: UICollectionViewCell {
    let itemLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textColor = .clear
        return view
    }()
    
    let itemDataLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 16)
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
        [itemLabel, itemDataLabel].forEach {
            contentView.addSubview($0)
        }
    }

    private func setConstraints() {
        itemLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12)
            make.leading.equalToSuperview().inset(12)
        }
        
        itemDataLabel.snp.makeConstraints { make in
            make.top.equalTo(itemLabel.snp.top).offset(1)
            make.leading.equalTo(itemLabel.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
            make.bottom.equalToSuperview().inset(12)
        }
    }
}