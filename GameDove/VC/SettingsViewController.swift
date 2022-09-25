//
//  SettingsViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/18.
//

import UIKit
import Toast

class SettingsViewController: BaseViewController {
    let repository = MainPlatformRepository()
    
    private lazy var settingTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        view.addSubview(settingTableView)
        navigationController?.navigationBar.topItem?.title = LocalizationKey.settings.localized
        
        if repository.fetch().first == nil {
            do {
                try repository.localRealm.write {
                    let platform = APIQuery.Platforms.nintendoSwitch
                    let defaultPlatform = MainPlatform(id: platform.rawValue, title: platform.title)
                    repository.localRealm.add(defaultPlatform)
                }
            } catch let error {
                print(error)
            }
        }
    }
    
    override func setConstraints() {
        settingTableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    private func platformaAtionSheet() {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancel = UIAlertAction(title: LocalizationKey.cancel.localized, style: .cancel)
        alert.addAction(cancel)
        
        APIQuery.Platforms.allCases.forEach { platform in
            let platform = UIAlertAction(title: platform.title, style: .default, handler: { [weak self] _ in
                guard let self = self else { return }
                self.changeMainPlatform(platform: platform)
            })
            alert.addAction(platform)
        }
        present(alert, animated: true)
    }
    
    private func changeMainPlatform(platform: APIQuery.Platforms) {
        do {
            try repository.localRealm.write {
                repository.updateItem(id: platform.rawValue, title: platform.title)
                settingTableView.reloadData()
                view.makeToast(LocalizationKey.changedMainPlatform.localized)
            }
        } catch let error {
            print(error)
        }
    }
}

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selected = Settings.allCases[indexPath.row]
        
        switch selected {
        case .mainPlatform:
            platformaAtionSheet()
            return
        case .contact:
            sendMail()
        case .review:
            openAppstore(id: 1645004525)
            return
        case .api:
            openWeb(urlStr: "https://rawg.io")
            return
        case .version:
            return
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Settings.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier) as? SettingsTableViewCell else {
            return UITableViewCell()
        }
        
        let set = Settings.allCases[indexPath.row]
        cell.titleLabel.text = set.title()
        cell.rightLabel.text = set.rightDetail()
        cell.selectionStyle = .none
        
        if Settings.allCases[indexPath.row] == .api || Settings.allCases[indexPath.row] == .mainPlatform {
            cell.rightLabel.textColor = ColorSet.shared.buttonActive
        } else {
            cell.rightLabel.textColor = ColorSet.shared.gray
        }
        
        return cell
    }
}
