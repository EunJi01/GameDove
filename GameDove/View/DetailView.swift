//
//  DetailView.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/13.
//

import UIKit
import SnapKit

class DetailView: BaseView {

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func configure() {
        [].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {

    }
}
