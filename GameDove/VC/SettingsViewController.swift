//
//  SettingsViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/18.
//

import UIKit
import Toast

class SettingsViewController: BaseViewController {
    
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
        
        APIQuery.Platforms.allCases.forEach { platform in // MARK: 플랫폼 저장 기능 추가하기
            let platform = UIAlertAction(title: APIQuery.Platforms.title(platform: platform), style: .default, handler: nil)
            alert.addAction(platform)
        }
        present(alert, animated: true)
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
            presentAppstore(id: 1645004525)
            return
        case .api:
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
        
        return cell
    }
}
