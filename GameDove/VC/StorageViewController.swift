//
//  StorageViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/18.
//

import UIKit
import SnapKit

class StorageViewController: BaseViewController {
    lazy var storageTableView: UITableView = {
        let view = UITableView(frame: .zero, style: .plain)
        view.register(StorageTableViewCell.self, forCellReuseIdentifier: StorageTableViewCell.reuseIdentifier)
        view.backgroundColor = .clear
        view.delegate = self
        view.dataSource = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func configure() {
        view.addSubview(storageTableView)
    }
    
    override func setConstraints() {
        storageTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}

extension StorageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StorageTableViewCell.reuseIdentifier) as? StorageTableViewCell else {
            return UITableViewCell()
        }
        
        cell.titleLabel.text = "TITLE"
        cell.releasedLabel.text = "released"
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
