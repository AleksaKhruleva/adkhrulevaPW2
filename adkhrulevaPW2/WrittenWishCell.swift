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
        selectionStyle = .none
        backgroundColor = .blue
        
        let wrap: UIView = UIView()
        
        contentView.addSubview(wrap)
        
        wrap.translatesAutoresizingMaskIntoConstraints = false
        wrap.backgroundColor = Constants.cellWrapColor
        wrap.layer.cornerRadius = Constants.cellWrapRadius

//        wrap.setHeight(50)
        wrap.pinVertical(to: self, Constants.cellWrapOffsetV)
        wrap.pinHorizontal(to: self, Constants.cellWrapOffsetH)
        
        wrap.addSubview(wishLabel)
        
        wishLabel.translatesAutoresizingMaskIntoConstraints = false
        wishLabel.pin(to: wrap, Constants.cellWishLabelOffset)
    }
}
