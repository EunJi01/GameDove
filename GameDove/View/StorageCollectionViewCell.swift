//
//  StorageCollectionViewCell.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/18.
//

import Foundation

import UIKit
import SnapKit

class StorageCollectionViewCell: UICollectionViewCell {
    let itemLabel: UILabel = {
        let view = UILabel()
        view.textColor = ColorSet.shared.buttonColor
        view.font = .boldSystemFont(ofSize: 17)
        return view
    }()
    
    let itemDataLabel: UILabel = {
        let view = UILabel()
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
            addSubview($0)
        }
    }

    private func setConstraints() {
        itemLabel.snp.makeConstraints { make in
            make.top.leading.equalToSuperview().inset(12)
        }
        
        itemDataLabel.snp.makeConstraints { make in
            make.top.equalTo(itemLabel.snp.bottom).offset(8)
            make.leading.equalTo(itemLabel.snp.leading)
        }
    }
}
