//
//  WishEventCell.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 03.02.2024.
//

import UIKit

final class WishEventCell: UICollectionViewCell {
    
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let notesLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureWrap()
        configureTitleLabel()
        configureNotesLabel()
        configureStartDateLabel()
        configureEndDateLabel()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEvent) {
        titleLabel.text = event.title
        notesLabel.text = event.notes
        startDateLabel.text = "\(ConstWishEvCell.startDateLabelText) \(event.startDate!.shortenDate)"
        endDateLabel.text = "\(ConstWishEvCell.endDateLabelText)   \(event.endDate!.shortenDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, ConstWishEvCell.wrapViewPin)
        wrapView.backgroundColor = .white
        wrapView.layer.cornerRadius = ConstCalendar.cornerRadius
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: ConstWishEvCell.titleLabelFS)
        titleLabel.numberOfLines = ConstWishEvCell.labelNoL
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.setWidth(ConstWishEvCell.labelWidth)
        titleLabel.pinTop(to: wrapView.topAnchor, ConstWishEvCell.titleLabelTop)
        titleLabel.pinLeft(to: wrapView.leadingAnchor, ConstWishEvCell.labelLeft)
    }
    
    private func configureNotesLabel() {
        addSubview(notesLabel)
        notesLabel.textColor = .lightGray
        notesLabel.font = UIFont.systemFont(ofSize: ConstWishEvCell.notesLabelFS)
        notesLabel.numberOfLines = ConstWishEvCell.labelNoL
        notesLabel.lineBreakMode = .byWordWrapping
        notesLabel.setWidth(ConstWishEvCell.labelWidth)
        notesLabel.pinTop(to: titleLabel.bottomAnchor, ConstWishEvCell.notesLabelTop)
        notesLabel.pinLeft(to: wrapView.leadingAnchor, ConstWishEvCell.labelLeft)
    }
    
    private func configureStartDateLabel() {
        addSubview(startDateLabel)
        startDateLabel.textColor = .darkGray
        startDateLabel.font = UIFont.systemFont(ofSize: ConstWishEvCell.notesLabelFS)
        startDateLabel.pinTop(to: notesLabel.bottomAnchor, ConstWishEvCell.startDateLabelTop)
        startDateLabel.pinLeft(to: wrapView.leadingAnchor, ConstWishEvCell.labelLeft)
    }
    
    private func configureEndDateLabel() {
        addSubview(endDateLabel)
        endDateLabel.textColor = .darkGray
        endDateLabel.font = UIFont.systemFont(ofSize: ConstWishEvCell.notesLabelFS)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, ConstWishEvCell.endDateLabelTop)
        endDateLabel.pinLeft(to: wrapView.leadingAnchor, ConstWishEvCell.labelLeft)
    }
}
