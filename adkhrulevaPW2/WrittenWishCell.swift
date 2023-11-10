//
//  WrittenWishCell.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 08.11.2023.
//

import Foundation
import UIKit

final class WrittenWishCell: UITableViewCell {
    
    static let writtenWishReuseId: String = Constants.writtenWishReuseId
    private let wishLabel: UILabel = UILabel()
    private let likeButton: UIButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
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
        addSubview(likeButton)
        
        likeButton.translatesAutoresizingMaskIntoConstraints = false
        likeButton.setImage(UIImage(systemName: Constants.likeButtonImageNormal), for: .normal)
        likeButton.tintColor = Constants.likeButtonTintColor
        
        likeButton.setHeight(self.bounds.height)
        likeButton.pinCenterY(to: self.centerYAnchor)
        likeButton.pinRight(to: self.trailingAnchor, Constants.likeButtonRight)
        
        addSubview(wishLabel)
        
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        wishLabel.numberOfLines = .zero
        selectionStyle = .none
        
        wishLabel.pinLeft(to: self.leadingAnchor, Constants.cellWrapOffsetH)
        wishLabel.setWidth(self.bounds.width / Constants.wishLabelWidthMult)
        wishLabel.pinVertical(to: self, Constants.cellWrapOffsetV)
    }
}
