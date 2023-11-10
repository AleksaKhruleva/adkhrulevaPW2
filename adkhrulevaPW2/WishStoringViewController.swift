//
//  WishStoringViewController.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 08.11.2023.
//

import Foundation
import UIKit

public var wishArray: [String] = [
    "I wish I could add cells to the table",
    "I wish I could add cells to the table",
    "I wish I could add cells to the table",
]

final class WishStoringViewController: UIViewController {
    
    private let closeButton: UIButton = UIButton(type: .system)
    private let tableView: UITableView = UITableView(frame: .zero)
    
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
        closeButton.layer.cornerRadius = Constants.hideButtonRadius
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        
        closeButton.pinRight(to: view.trailingAnchor, Constants.closeButtonTrailing)
        closeButton.pinTop(to: view.topAnchor, Constants.closeButtonTop)
    }
    
    private func configureTable() {
        tableView.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.writtenWishReuseId)
        tableView.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.addWishReuseId)
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.backgroundColor = .systemPink
        tableView.separatorStyle = .none
        tableView.rowHeight = 150
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

// MARK: - UITableViewDataSource & UITextFieldDelegate
extension WishStoringViewController: UITableViewDataSource, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (section == Constants.sectionZero) {
            return Constants.sectionZeroRows
        } else {
            return wishArray.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.tableSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.section == Constants.sectionZero) {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.addWishReuseId, for: indexPath)
            guard let addWishCell = cell as? AddWishCell else { return cell }
            addWishCell.tableView = tableView
            addWishCell.wishTextField.tag = indexPath.row
            addWishCell.wishTextField.delegate = self
            return addWishCell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.writtenWishReuseId, for: indexPath)
            guard let wishCell = cell as? WrittenWishCell else { return cell }
            wishCell.configure(with: wishArray[indexPath.row])
            return wishCell
        }
    }
}
