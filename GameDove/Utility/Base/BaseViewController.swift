//
//  BaseViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/08.
//

import UIKit

class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setConstraints()
        navigationItemColor()
        view.backgroundColor = ColorSet.shared.backgroundColor
    }
    
    private func navigationItemColor() {
        let navigation = UINavigationBarAppearance()
        //navigation.backgroundColor = .tertiarySystemFill
        navigationController?.navigationBar.scrollEdgeAppearance = navigation
        navigationController?.navigationBar.tintColor = ColorSet.shared.buttonColor
        navigationController?.toolbar.tintColor = ColorSet.shared.buttonColor
    }
    
    func tapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(viewTapped(_:)))
        tapGestureRecognizer.cancelsTouchesInView = false // 중요!
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @objc private func viewTapped(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    func configure() {}
    func setConstraints() {}
}
