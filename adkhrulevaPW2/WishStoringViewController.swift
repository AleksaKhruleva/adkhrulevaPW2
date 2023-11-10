//
//  WishStoringViewController.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 08.11.2023.
//

import Foundation
import UIKit

final class WishStoringViewController: UIViewController {
    
    private let closeButton: UIButton = UIButton(type: .system)
    private let tableView: UITableView = UITableView(frame: .zero)
    
    private var wishArray: [String] = ["I wish I could add cells to the table"]
    
    override func viewDidLoad() {
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        configureCloseButton()
        configureTable()
    }
    
    private func configureCloseButton() {
        view.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle(Constants.closeButtonText, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.closeButtonTitleFS, weight: .bold)
        closeButton.layer.cornerRadius = Constants.buttonRadius
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        
        closeButton.pinRight(to: view.trailingAnchor, Constants.closeButtonTrailing)
        closeButton.pinTop(to: view.topAnchor, Constants.closeButtonTop)
    }
    
    private func configureTable() {
        view.addSubview(tableView)
        
        tableView.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        
        tableView.backgroundColor = .systemPink
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.layer.cornerRadius = Constants.tableCornerRadius
        
        tableView.pinTop(to: closeButton.bottomAnchor, Constants.tableTop)
        tableView.pinBottom(to: view, Constants.tableBottom)
        tableView.pinHorizontal(to: view, Constants.tableHorizontal)
    }
    
    @objc
    private func closeButtonPressed() {
        dismiss(animated: true)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == Constants.sectionOne) {
            return Constants.sectionOneRows
        } else {
            return wishArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.tableSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == Constants.sectionZero) {
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath)
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            wishCell.configure(with: wishArray[indexPath.row])
            return wishCell
        }
        return UITableViewCell(frame: .zero)
    }
}
