//
//  WishEventCreationView.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 03.02.2024.
//

import UIKit

final class WishEventCreationView: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private let closeButton: UIButton = UIButton(type: .system)
    private let titleField: UITextField = UITextField()
    private let notesField: UITextField = UITextField()
    private let startDateLabel: UILabel = UILabel()
    private let startDatePicker: UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private let endDateLabel: UILabel = UILabel()
    private let endDatePicker: UIDatePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
    private let addEventButton: UIButton = UIButton(type: .system)
    
    var didSelectItem: ((_ item: WishEvent) -> Void)?
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Vars.oppositeBackgroundColor
        configureCloseButton()
        configureTitleField()
        configurenotesField()
        configureStartDatePicker()
        configureStartDateLabel()
        configureEndDatePicker()
        configureEndDateLabel()
        configureAddEventButton()
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
    
    private func configurenotesField() {
        view.addSubview(notesField)
        
        notesField.translatesAutoresizingMaskIntoConstraints = false
        notesField.backgroundColor = .white
        notesField.layer.cornerRadius = Constants.buttonCornerRadius
        notesField.placeholder = "Notes..."
        notesField.returnKeyType = UIReturnKeyType.done
        
        notesField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        notesField.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        notesField.leftViewMode = .always
        notesField.rightViewMode = .always
        
        notesField.setHeight(Constants.buttonHeight)
        notesField.setWidth(Constants.stackWidth)
        notesField.pinCenterX(to: view.centerXAnchor)
        notesField.pinTop(to: titleField.bottomAnchor, 10)
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
        
        startDatePicker.pinTop(to: notesField.bottomAnchor, 10)
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
        addEventButton.setTitleColor(.white, for: .highlighted)
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
        let startDateConv = startDatePicker.date.convertedDate
        var endDateConv = endDatePicker.date.convertedDate
        
        if titleField.text != nil && titleField.text?.isEmpty == false && (startDateConv <= endDateConv) {
            endDateConv = endDateConv.addingTimeInterval(23 * 60 * 60 + 59 * 60)
            
            let calendarEvent = CalendarEventModel(
                title: titleField.text!,
                note: notesField.text,
                startDate: startDateConv,
                endDate: endDateConv
            )
            
            let result = CalendarManager().create(eventModel: calendarEvent)
            
            if result {
                let event = WishEvent(context: context)
                event.title = titleField.text
                event.notes = notesField.text
                event.startDate = startDateConv
                event.endDate = endDateConv
                
                do {
                    try context.save()
                    didSelectItem?(event)
                    dismiss(animated: true)
                } catch {
                    // TODO: show alert here
                }
            } else {
                // TODO: show alert here
            }
        } else {
            // TODO: show alert here
            print("INCORRECT DATA")
        }
        
        
        
    }
}

