//
//  StorageViewController.swift
//  GameDove
//
//  Created by 황은지 on 2022/09/18.
//

import UIKit
import SnapKit
import RealmSwift

final class StorageViewController: BaseViewController {
    let repository = StorageRepository()
    var tasks: Results<Storage>!
    
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
        fetchRealm()
    }

    override func configure() {
        view.addSubview(storageTableView)
        navigationController?.navigationBar.topItem?.title = LocalizationKey.storage.localized
        let deleteAll = UIBarButtonItem(image: IconSet.trash, style: .plain, target: self, action: #selector(showDeleteAlert))
        deleteAll.tintColor = ColorSet.shared.button
        navigationItem.rightBarButtonItems = [deleteAll]
    }
    
    override func setConstraints() {
        storageTableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    @objc private func showDeleteAlert() {
        let alert = UIAlertController(title: nil, message: LocalizationKey.deleteAll.localized, preferredStyle: .alert)
        let cancel = UIAlertAction(title: LocalizationKey.cancel.localized, style: .cancel)
        let delete = UIAlertAction(title: LocalizationKey.delete.localized, style: .destructive) { [weak self] _ in
            self?.repository.deleteAll()
            self?.storageTableView.reloadData()
        }
        
        alert.addAction(cancel)
        alert.addAction(delete)
        self.present(alert, animated: true)
    }

    private func fetchRealm() {
        tasks = repository.fetch()
        storageTableView.reloadData()
    }
    
    private func isUpcoming(released: String) -> Bool {
        let releaseDate = APIQuery.dateFormatter(released: released)
        let result = releaseDate > Date()
        
        return result ? true : false
    }
}

extension StorageViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: StorageTableViewCell.reuseIdentifier) as? StorageTableViewCell else {
            return UITableViewCell()
        }
        
        cell.selectionStyle = .none
        cell.titleLabel.text = tasks[indexPath.row].title
        cell.releasedLabel.text = tasks[indexPath.row].released
        cell.backgroundColor = .clear
        
        let isupcoming = isUpcoming(released: tasks[indexPath.row].released)
        cell.releasedLabel.textColor = isupcoming ? ColorSet.shared.buttonActive : ColorSet.shared.gray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: nil) { [weak self] _, _, _ in
            guard let self = self else { return }
            self.repository.deleteGame(game: self.tasks[indexPath.row])
            self.fetchRealm()
        }

        delete.image = IconSet.trashFill
        delete.backgroundColor = .systemRed
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        vc.id = "\(tasks[indexPath.row].id)"
        vc.hidesBottomBarWhenPushed = true
        transition(vc, transitionStyle: .push)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
