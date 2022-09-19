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
        view.textColor = ColorSet.shared.buttonColor
        view.font = .boldSystemFont(ofSize: 20)
        return view
    }()
    
    let itemDataLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 2
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
            make.top.equalTo(itemLabel.snp.top).offset(1)
            make.leading.equalTo(itemLabel.snp.trailing).offset(12)
            make.trailing.equalToSuperview().inset(12)
        }
    }
}
