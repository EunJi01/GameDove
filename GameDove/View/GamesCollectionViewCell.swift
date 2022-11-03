//
//  GameListCollectionViewCell.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/08.
//

import UIKit

class GamesCollectionViewCell: UICollectionViewCell {
    let cellBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorSet.shared.objectBack
        view.clipsToBounds = true
        view.layer.borderColor = ColorSet.shared.gray.cgColor
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        return view
    }()
    
    let mainImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = ColorSet.shared.gray
        return view
    }()
    
    let titleLabel: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = .pretendardBoldFont(size: 19)
        return view
    }()
    
    let separateView: UIView = {
        let view = UIView()
        view.backgroundColor = ColorSet.shared.gray
        return view
    }()
    
    let inDetailLabel: UILabel = {
        let view = UILabel()
        view.text = LocalizationKey.inDetail.localized
        view.font = .pretendardRegularFont(size: 12)
        view.textColor = .gray
        return view
    }()
    
    let releasedLabel: UILabel = {
        let view = UILabel()
        view.font = .pretendardRegularFont(size: 12)
        view.textColor = .black
        return view
    }()
    
    let metascoreLabel: UILabel = {
        let view = UILabel()
        view.backgroundColor = ColorSet.shared.clearBlack
        view.textColor = .white
        view.font = .pretendardMediumFont(size: 14)
        view.textAlignment = .center
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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        mainImageView.image = nil
    }
    
    func configure() {
        addSubview(cellBackgroundView)
        [mainImageView, titleLabel, separateView, inDetailLabel, releasedLabel, metascoreLabel].forEach {
            cellBackgroundView.addSubview($0)
        }
    }
    
    func setConstraints() {
        cellBackgroundView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self).inset(20)
            make.bottom.equalTo(self).offset(-20)
        }
        
        mainImageView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            make.centerX.equalTo(snp.centerX)
            make.width.equalTo(cellBackgroundView)
            make.height.equalTo(180)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(mainImageView.snp.bottom).offset(12)
            make.leading.trailing.equalTo(mainImageView).inset(12)
        }
        
        separateView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalTo(titleLabel)
            make.height.equalTo(1)
        }
        
        inDetailLabel.snp.makeConstraints { make in
            make.top.equalTo(separateView.snp.bottom).offset(8)
            make.trailing.equalTo(separateView)
        }
        
        releasedLabel.snp.makeConstraints { make in
            make.top.equalTo(separateView.snp.bottom).offset(8)
            make.leading.equalTo(separateView)
        }
        
        metascoreLabel.snp.makeConstraints { make in
            make.bottom.equalTo(mainImageView.snp.bottom).inset(12)
            make.trailing.equalTo(mainImageView.snp.trailing).inset(12)
            make.height.equalTo(24)
            make.width.equalTo(36)
        }
    }
}
