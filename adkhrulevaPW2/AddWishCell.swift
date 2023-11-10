//
//  AddWishCell.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 10.11.2023.
//

import UIKit

final class AddWishCell: UITableViewCell, UITextFieldDelegate {
    
    static let addWishReuseId: String = Constants.addWishReuseId
    let wishTextField: UITextField = UITextField()
    private let addWishButton: UIButton = UIButton()
    
    var tableView: UITableView?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    private func configureUI() {
        configureText()
    }
    
    private func configureText() {
        selectionStyle = .none
        backgroundColor = .black
        
        let wrap: UIView = UIView()
        
        contentView.addSubview(wrap)
        
        wrap.translatesAutoresizingMaskIntoConstraints = false
        wrap.backgroundColor = Constants.cellWrapColor
        wrap.layer.cornerRadius = Constants.cellWrapRadius
        
        wrap.pinVertical(to: self, Constants.cellWrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.cellWrapOffsetH)
        
        wrap.addSubview(wishTextField)
        
        wishTextField.translatesAutoresizingMaskIntoConstraints = false
        wishTextField.delegate = self
        wishTextField.backgroundColor = .cyan
        wishTextField.placeholder = "Here"
        
        wishTextField.pin(to: wrap, Constants.cellWishLabelOffset)
        
        contentView.addSubview(addWishButton)
        
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setTitle("Add new wish", for: .normal)
        addWishButton.setTitleColor(.yellow, for: .normal)
        addWishButton.setTitleColor(.black, for: .highlighted)
        addWishButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.closeButtonTitleFS, weight: .bold)
        addWishButton.layer.cornerRadius = Constants.hideButtonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
        addWishButton.pinTop(to: wrap.bottomAnchor, 10)
    }
    
    @objc
    private func addWishButtonPressed() {
        if let wish = wishTextField.text {
            if wish.isEmpty == false {
                print("HERE")
                if wishArray != nil {
                    print("Done")
                    wishArray.append(wish)
                    print(tableView?.rowHeight)
                    tableView!.reloadData()
                }
            }
        }
    }
}
