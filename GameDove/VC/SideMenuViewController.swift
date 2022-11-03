//
//  SideMenuViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/10/02.
//

import UIKit
import SnapKit

final class SideMenuViewController: BaseViewController {
    private let storageButton: UIButton = {
        let view = UIButton()
        view.setTitle(LocalizationKey.storage.localized, for: .normal)
        view.setImage(SideMenuIconSet.storage, for: .normal)
        return view
    }()
    
    private let settingsButton: UIButton = {
        let view = UIButton()
        view.setTitle(LocalizationKey.settings.localized, for: .normal)
        view.setImage(SideMenuIconSet.setting, for: .normal)
        return view
    }()
    
    private let metascoreButton: UIButton = {
        let view = UIButton()
        view.setTitle(LocalizationKey.metascore.localized, for: .normal)
        view.setImage(SideMenuIconSet.metascore, for: .normal)
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        storageButton.addTarget(self, action: #selector(storageButtonTapped), for: .touchUpInside)
        settingsButton.addTarget(self, action: #selector(settingsButtonTapped), for: .touchUpInside)
        metascoreButton.addTarget(self, action: #selector(metascoreButtonTapped), for: .touchUpInside)
    }
    
    override func configure() {
        [metascoreButton, storageButton, settingsButton].forEach {
            view.addSubview($0)
            $0.tintColor = ColorSet.shared.button
            $0.setTitleColor(ColorSet.shared.button, for: .normal)
            $0.titleLabel?.font = .pretendardRegularFont(size: 19)
            $0.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: -10)
            $0.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 20)
        }
    }
    
    override func setConstraints() {
        metascoreButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(60)
            make.leading.equalTo(view.safeAreaLayoutGuide).offset(16)
        }
        
        storageButton.snp.makeConstraints { make in
            make.top.equalTo(metascoreButton.snp.bottom).offset(16)
            make.leading.equalTo(metascoreButton)
        }
        
        settingsButton.snp.makeConstraints { make in
            make.top.equalTo(storageButton.snp.bottom).offset(16)
            make.leading.equalTo(storageButton)
        }
    }
    
    @objc private func metascoreButtonTapped() {
        let vc = MetascoreGameViewController()
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func storageButtonTapped() {
        let vc = StorageViewController()
        vc.navigationItem.title = LocalizationKey.storage.localized
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc private func settingsButtonTapped() {
        let vc = SettingsViewController()
        vc.navigationItem.title = LocalizationKey.settings.localized
        vc.hidesBottomBarWhenPushed = true
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
