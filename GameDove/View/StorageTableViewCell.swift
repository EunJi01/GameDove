//
//  StorageCollectionViewCell.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/18.
//

import UIKit
import SnapKit

class StorageTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = ColorSet.shared.button
        view.font = .boldSystemFont(ofSize: 22)
        return view
    }()
    
    let releasedLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 15)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configure() {
        [titleLabel, releasedLabel].forEach {
            addSubview($0)
        }
    }

    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(18)
            make.top.equalTo(16)
        }
        
        releasedLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(3)
        }
    }
}
