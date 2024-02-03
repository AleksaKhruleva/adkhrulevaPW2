//
//  WishStoringViewController.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 08.11.2023.
//

import UIKit

final class WishStoringViewController: UIViewController {
    
    private let closeButton: UIButton = UIButton(type: .system)
    private let wishField: UITextField = UITextField()
    private let addWishButton: UIButton = UIButton(type: .system)
    private let tableView: UITableView = UITableView(frame: .zero)
    private let defaults = UserDefaults.standard
    
    private var wishArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        wishArray = defaults.array(forKey: Constants.wishArrayKey) as? [String] ?? []
        wishField.delegate = self
        tableView.dataSource = self
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = Vars.oppositeBackgroundColor
        configureCloseButton()
        configureWishField()
        configureAddWishButton()
        configureTable()
    }
    
    private func configureCloseButton() {
        view.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        let largeFont = UIFont.systemFont(ofSize: 20, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "xmark", withConfiguration: configuration)
        closeButton.setImage(image, for: .normal)
        closeButton.tintColor = Vars.backgroundColor
        closeButton.layer.cornerRadius = Constants.buttonCornerRadius
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        
        closeButton.pinRight(to: view.trailingAnchor, Constants.closeButtonTrailing)
        closeButton.pinTop(to: view.topAnchor, Constants.closeButtonTop)
    }
    
    private func configureWishField() {
        view.addSubview(wishField)
        
        wishField.translatesAutoresizingMaskIntoConstraints = false
        wishField.backgroundColor = .white
        wishField.layer.cornerRadius = Constants.buttonCornerRadius
        wishField.placeholder = Constants.wishFieldPlaceholder
        wishField.returnKeyType = UIReturnKeyType.done
        
        wishField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        wishField.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        wishField.leftViewMode = .always
        wishField.rightViewMode = .always
        
        wishField.setHeight(Constants.buttonHeight)
        wishField.setWidth(Constants.stackWidth)
        wishField.pinCenterX(to: view.centerXAnchor)
        wishField.pinTop(to: closeButton.bottomAnchor, Constants.wishFieldTop)
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setTitle(Constants.addWishButtonText, for: .normal)
        addWishButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        addWishButton.setTitleColor(view.backgroundColor, for: .normal)
        addWishButton.setTitleColor(.white, for: .highlighted)
        addWishButton.setTitleColor(.lightGray, for: .disabled)
        addWishButton.backgroundColor = .white
        addWishButton.layer.cornerRadius = Constants.buttonCornerRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.setWidth(Constants.stackWidth)
        addWishButton.pinCenterX(to: view.centerXAnchor)
        addWishButton.pinTop(to: wishField.bottomAnchor, Constants.addWishButtonTop)
    }
    
    private func configureTable() {
        tableView.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.writtenWishReuseId)
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = Constants.tableCornerRadius
        
        tableView.setWidth(Constants.stackWidth)
        tableView.pinCenterX(to: view.centerXAnchor)
        tableView.pinTop(to: addWishButton.bottomAnchor, Constants.tableTop)
        tableView.pinBottom(to: view, Constants.tableBottom)
    }
    
    @objc
    private func closeButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc
    private func addWishButtonPressed() {
        self.view.endEditing(true)
        if let text = wishField.text {
            let wish = text.trimmingCharacters(in: .whitespacesAndNewlines)
            if wish.isEmpty {
                showAlert()
            } else {
                wishArray.append(wish)
                wishArray.sort { (lhs: String, rhs: String) -> Bool in
                    return lhs.lowercased() < rhs.lowercased()
                }
                defaults.set(wishArray, forKey: Constants.wishArrayKey)
                tableView.reloadData()
            }
            wishField.text = String()
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: Constants.alertTitle, message: Constants.alertMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.alertActionOK, style: .default))
        self.present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return wishArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.tableSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.writtenWishReuseId, for: indexPath)
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        wishCell.configure(with: wishArray[indexPath.row])
        return wishCell
    }
}

// MARK: - UITableViewDelegate
extension WishStoringViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            wishArray.remove(at: indexPath.row)
            defaults.set(wishArray, forKey: Constants.wishArrayKey)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}

// MARK: - UITextFieldDelegate
extension WishStoringViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        addWishButtonPressed()
        return false
    }
}
