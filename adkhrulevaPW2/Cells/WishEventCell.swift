//
//  WishEventCell.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 03.02.2024.
//

import UIKit

final class WishEventCell: UICollectionViewCell {
    
    static let reuseIdentifier: String = "WishEventCell"
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
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEvent) {
        titleLabel.text = event.title
        notesLabel.text = event.notes
        startDateLabel.text = "Start: \(event.startDate!.shortenDate)"
        endDateLabel.text = "End:   \(event.endDate!.shortenDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, 5)
        wrapView.backgroundColor = .white
        wrapView.layer.cornerRadius = ConstCalendar.cornerRadius
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .black
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.setWidth(140)
        titleLabel.pinTop(to: wrapView.topAnchor, 15)
        titleLabel.pinLeft(to: wrapView.leadingAnchor, 15)
    }
    
    private func configureNotesLabel() {
        addSubview(notesLabel)
        notesLabel.textColor = .lightGray
        notesLabel.font = UIFont.systemFont(ofSize: 15)
        notesLabel.numberOfLines = 2
        notesLabel.lineBreakMode = .byWordWrapping
        notesLabel.setWidth(140)
        notesLabel.pinTop(to: titleLabel.bottomAnchor, 5)
        notesLabel.pinLeft(to: wrapView.leadingAnchor, 15)
    }
    
    private func configureStartDateLabel() {
        addSubview(startDateLabel)
        startDateLabel.textColor = .darkGray
        startDateLabel.font = UIFont.systemFont(ofSize: 15)
        startDateLabel.pinTop(to: notesLabel.bottomAnchor, 5)
        startDateLabel.pinLeft(to: wrapView.leadingAnchor, 15)
    }
    
    private func configureEndDateLabel() {
        addSubview(endDateLabel)
        endDateLabel.textColor = .darkGray
        endDateLabel.font = UIFont.systemFont(ofSize: 15)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, 2)
        endDateLabel.pinLeft(to: wrapView.leadingAnchor, 15)
    }
}
