//
//  SettingsTableViewCell.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/18.
//

import UIKit

class SettingsTableViewCell: UITableViewCell {
    let titleLabel: UILabel = {
        let view = UILabel()
        return view
    }()
    
    let rightLabel: UILabel = {
        let view = UILabel()
        view.textColor = ColorSet.shared.gray
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
        [titleLabel, rightLabel].forEach {
            addSubview($0)
        }
    }

    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(14)
        }
        
        rightLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(14)
        }
    }
}
