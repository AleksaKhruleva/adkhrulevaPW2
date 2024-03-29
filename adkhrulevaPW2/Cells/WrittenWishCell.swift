//
//  WrittenWishCell.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 08.11.2023.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    
    static let writtenWishReuseId: String = Constants.writtenWishReuseId
    private let wishLabel: UILabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    private func configureUI() {
        addSubview(wishLabel)
        
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        wishLabel.numberOfLines = .zero
        selectionStyle = .none
        
        
        wishLabel.pinLeft(to: leadingAnchor, Constants.cellWrapOffsetH)
        wishLabel.pinRight(to: trailingAnchor, Constants.cellWrapOffsetH)
        wishLabel.pinTop(to: topAnchor, Constants.cellWrapOffsetV).priority = UILayoutPriority(Constants.writtenWCLayoutPriority)
        wishLabel.pinBottom(to: bottomAnchor, Constants.cellWrapOffsetV).priority = UILayoutPriority(Constants.writtenWCLayoutPriority)
    }
}
