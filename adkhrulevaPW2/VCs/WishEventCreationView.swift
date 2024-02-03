//
//  WishEventCreationView.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 03.02.2024.
//

import UIKit

final class WishEventCreationView: UIViewController {
    
    private let closeButton: UIButton = UIButton(type: .system)
    private let titleField: UITextField = UITextField()
    private let descriptionField: UITextField = UITextField()
    private let startDateLabel: UILabel = UILabel()
    private let startDatePicker: UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private let endDateLabel: UILabel = UILabel()
    private let endDatePicker: UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private let addEventButton: UIButton = UIButton(type: .system)
    
    var didSelectItem: ((_ item: [WishEventModel]) -> Void)?
    private var eventArray: [WishEventModel]
    
    init(eventArray: [WishEventModel]) {
        self.eventArray = eventArray
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LifecyclewishArray
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        configureCloseButton()
        configureTitleField()
        configureDescriptionField()
        configureStartDatePicker()
        configureStartDateLabel()
        configureEndDatePicker()
        configureEndDateLabel()
        configureAddEventButton()
    }
    
    // MARK: - UI Configuration
    private func configureCloseButton() {
        view.addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle(Constants.closeButtonText, for: .normal)
        closeButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.closeButtonTitleFS, weight: .bold)
        closeButton.layer.cornerRadius = Constants.buttonCornerRadius
        closeButton.addTarget(self, action: #selector(closeButtonPressed), for: .touchUpInside)
        
        closeButton.pinRight(to: view.trailingAnchor, Constants.closeButtonTrailing)
        closeButton.pinTop(to: view.topAnchor, Constants.closeButtonTop)
    }
    
    private func configureTitleField() {
        view.addSubview(titleField)
        
        titleField.translatesAutoresizingMaskIntoConstraints = false
        titleField.backgroundColor = .white
        titleField.layer.cornerRadius = Constants.buttonCornerRadius
        titleField.placeholder = "Title..."
        titleField.returnKeyType = UIReturnKeyType.done
        
        titleField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        titleField.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        titleField.leftViewMode = .always
        titleField.rightViewMode = .always
        
        titleField.setHeight(Constants.buttonHeight)
        titleField.setWidth(Constants.stackWidth)
        titleField.pinCenterX(to: view.centerXAnchor)
        titleField.pinTop(to: closeButton.bottomAnchor, 10)
    }
    
    private func configureDescriptionField() {
        view.addSubview(descriptionField)
        
        descriptionField.translatesAutoresizingMaskIntoConstraints = false
        descriptionField.backgroundColor = .white
        descriptionField.layer.cornerRadius = Constants.buttonCornerRadius
        descriptionField.placeholder = "Description..."
        descriptionField.returnKeyType = UIReturnKeyType.done
        
        descriptionField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        descriptionField.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        descriptionField.leftViewMode = .always
        descriptionField.rightViewMode = .always
        
        descriptionField.setHeight(Constants.buttonHeight)
        descriptionField.setWidth(Constants.stackWidth)
        descriptionField.pinCenterX(to: view.centerXAnchor)
        descriptionField.pinTop(to: titleField.bottomAnchor, 10)
    }
    
    private func configureStartDateLabel() {
        view.addSubview(startDateLabel)
        
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.text = "Start date..."
        startDateLabel.textColor = .black
        startDateLabel.font = UIFont.systemFont(ofSize: 20)
        startDateLabel.lineBreakMode = .byWordWrapping
        startDateLabel.numberOfLines = 1
        
        startDateLabel.pinLeft(to: view.leadingAnchor, 40)
        startDateLabel.pinVertical(to: startDatePicker)
    }
    
    private func configureStartDatePicker() {
        view.addSubview(startDatePicker)
        
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.datePickerMode = .date
        startDatePicker.minimumDate = Date()
        startDatePicker.calendar = .autoupdatingCurrent
        
        startDatePicker.pinTop(to: descriptionField.bottomAnchor, 10)
        startDatePicker.pinRight(to: view.trailingAnchor, 20)
    }
    
    private func configureEndDateLabel() {
        view.addSubview(endDateLabel)
        
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.text = "End date..."
        endDateLabel.textColor = .black
        endDateLabel.font = UIFont.systemFont(ofSize: 20)
        endDateLabel.lineBreakMode = .byWordWrapping
        endDateLabel.numberOfLines = 1
        
        endDateLabel.pinLeft(to: view.leadingAnchor, 40)
        endDateLabel.pinVertical(to: endDatePicker)
    }
    
    private func configureEndDatePicker() {
        view.addSubview(endDatePicker)
        
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.datePickerMode = .date
        endDatePicker.minimumDate = Date()
        endDatePicker.calendar = .autoupdatingCurrent
        
        endDatePicker.pinTop(to: startDatePicker.bottomAnchor, 10)
        endDatePicker.pinRight(to: view.trailingAnchor, 20)
    }
    
    private func configureAddEventButton() {
        view.addSubview(addEventButton)
        
        addEventButton.translatesAutoresizingMaskIntoConstraints = false
        addEventButton.setTitle("Add event", for: .normal)
        addEventButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        addEventButton.setTitleColor(view.backgroundColor, for: .normal)
        addEventButton.backgroundColor = .white
        addEventButton.layer.cornerRadius = Constants.buttonCornerRadius
        addEventButton.addTarget(self, action: #selector(addEventButtonPressed), for: .touchUpInside)
        
        addEventButton.setHeight(Constants.buttonHeight)
        addEventButton.setWidth(Constants.stackWidth)
        addEventButton.pinCenterX(to: view.centerXAnchor)
        addEventButton.pinTop(to: endDatePicker.bottomAnchor, 20)
    }
    
    @objc
    private func closeButtonPressed() {
        dismiss(animated: true)
    }
    
    @objc
    private func addEventButtonPressed() {
        let newEvent = WishEventModel(
            title: titleField.text ?? "test",
            description: descriptionField.text ?? "test",
            startDate: startDatePicker.date.convertedDate,
            endDate: endDatePicker.date.convertedDate)
        
        eventArray.append(newEvent)
        didSelectItem?(eventArray)
        dismiss(animated: true)
    }
}

