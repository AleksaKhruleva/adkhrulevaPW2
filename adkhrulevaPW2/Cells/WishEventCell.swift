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
        configurenotesLabel()
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
        startDateLabel.text = "Start Date: \(event.startDate!.shortenDate)"
        endDateLabel.text = "End Date: \(event.endDate!.shortenDate)"
    }
    
    // MARK: - UI Configuration
    private func configureWrap() {
        addSubview(wrapView)
        wrapView.pin(to: self, 5)
        wrapView.layer.cornerRadius = ConstCalendar.cornerRadius
        wrapView.backgroundColor = ConstCalendar.backgroundColor
    }
    
    private func configureTitleLabel() {
        addSubview(titleLabel)
        titleLabel.textColor = .white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        titleLabel.pinTop(to: wrapView, 20)
        titleLabel.pinLeft(to: wrapView, 20)
    }
    
    private func configurenotesLabel() {
        addSubview(notesLabel)
        notesLabel.textColor = .white
        notesLabel.font = UIFont.systemFont(ofSize: 15)
        notesLabel.pinTop(to: wrapView, 25)
        notesLabel.pinLeft(to: titleLabel.trailingAnchor, 10)
    }
    
    private func configureStartDateLabel() {
        addSubview(startDateLabel)
        startDateLabel.textColor = .lightGray
        startDateLabel.font = UIFont.systemFont(ofSize: 10)
        startDateLabel.pinTop(to: titleLabel.bottomAnchor, 5)
        startDateLabel.pinLeft(to: wrapView, 20)
    }
    
    private func configureEndDateLabel() {
        addSubview(endDateLabel)
        endDateLabel.textColor = .lightGray
        endDateLabel.font = UIFont.systemFont(ofSize: 10)
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, 2)
        endDateLabel.pinLeft(to: wrapView, 20)
    }
}
