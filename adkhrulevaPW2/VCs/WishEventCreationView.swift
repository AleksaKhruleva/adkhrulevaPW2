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
    private let hintLabel: UILabel = UILabel()
    private let tableView: UITableView = UITableView(frame: .zero)
    private let notesField: UITextField = UITextField()
    private let dateBackgroundView: UIView = UIView()
    private let startDateLabel: UILabel = UILabel()
    private let startDatePicker: UIDatePicker = UIDatePicker(frame: .zero)
    private let endDateLabel: UILabel = UILabel()
    private let endDatePicker: UIDatePicker = UIDatePicker(frame: .zero)
    private let addEventButton: UIButton = UIButton(type: .system)
    private let defaults = UserDefaults.standard
    
    private var wishArray: [String] = []
    private var filteredWishArray: [String] = []
    
    var didSelectItem: ((_ item: WishEvent) -> Void)?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        wishArray = defaults.array(forKey: Constants.wishArrayKey) as? [String] ?? []
        filteredWishArray = wishArray
        tableView.dataSource = self
        tableView.delegate = self
        titleField.delegate = self
        titleField.addTarget(self, action: #selector(valueChanged), for: .allEditingEvents)
        notesField.delegate = self
        configureUI()
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Vars.oppositeBackgroundColor
        configureCloseButton()
        configureTitleField()
        configureHintLable()
        configureTable()
        configureNotesField()
        
        configureDateBackgroundView()
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
    
    private func configureHintLable() {
        view.addSubview(hintLabel)
        
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.text = "Come up with a new wish or select from saved ones:"
        hintLabel.textColor = .white
        hintLabel.font = UIFont.systemFont(ofSize: 17)
        hintLabel.lineBreakMode = .byWordWrapping
        hintLabel.numberOfLines = 0
        
        hintLabel.setWidth(Constants.stackWidth)
        hintLabel.pinLeft(to: view.leadingAnchor, 25)
        hintLabel.pinTop(to: titleField.bottomAnchor, 10)
    }
    
    private func configureTable() {
        tableView.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.writtenWishReuseId)
        
        view.addSubview(tableView)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.backgroundColor = .white
        tableView.separatorStyle = .singleLine
        tableView.separatorInset = .zero
        tableView.allowsSelection = true
        tableView.showsVerticalScrollIndicator = false
        tableView.layer.cornerRadius = Constants.tableCornerRadius
        
        tableView.setWidth(Constants.stackWidth)
        tableView.setHeight(122)
        tableView.pinCenterX(to: view.centerXAnchor)
        tableView.pinTop(to: hintLabel.bottomAnchor, 10)
    }
    
    private func configureNotesField() {
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
        notesField.pinTop(to: tableView.bottomAnchor, 10)
    }
    
    private func configureDateBackgroundView() {
        view.addSubview(dateBackgroundView)
        dateBackgroundView.addSubview(startDateLabel)
        dateBackgroundView.addSubview(startDatePicker)
        dateBackgroundView.addSubview(endDateLabel)
        dateBackgroundView.addSubview(endDatePicker)
        
        dateBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        dateBackgroundView.backgroundColor = .white
        dateBackgroundView.layer.cornerRadius = 20
        
        dateBackgroundView.setWidth(Constants.stackWidth)
        dateBackgroundView.setHeight(99)
        dateBackgroundView.pinCenterX(to: view.centerXAnchor)
        dateBackgroundView.pinTop(to: notesField.bottomAnchor, 10)
        
        configureStartDateLabel()
        configureStartDatePicker()
        configureEndDateLabel()
        configureEndDatePicker()
    }
    
    private func configureStartDateLabel() {
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.text = "Start date:"
        startDateLabel.textColor = .black
        startDateLabel.font = UIFont.systemFont(ofSize: 17)
        startDateLabel.lineBreakMode = .byWordWrapping
        startDateLabel.numberOfLines = 1
        
        startDateLabel.pinTop(to: dateBackgroundView.topAnchor, 10)
        startDateLabel.pinLeft(to: dateBackgroundView.leadingAnchor, 20)
    }
    
    private func configureStartDatePicker() {
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.datePickerMode = .date
        startDatePicker.minimumDate = Date()
        startDatePicker.calendar = .autoupdatingCurrent
        
        startDatePicker.pinVertical(to: startDateLabel)
        startDatePicker.pinRight(to: dateBackgroundView.trailingAnchor, 10)
    }
    
    private func configureEndDateLabel() {
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.text = "End date:"
        endDateLabel.textColor = .black
        endDateLabel.font = UIFont.systemFont(ofSize: 17)
        endDateLabel.lineBreakMode = .byWordWrapping
        endDateLabel.numberOfLines = 1
        
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, 10)
        endDateLabel.pinLeft(to: dateBackgroundView.leadingAnchor, 20)
    }
    
    private func configureEndDatePicker() {
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.datePickerMode = .date
        endDatePicker.minimumDate = Date()
        endDatePicker.calendar = .autoupdatingCurrent
        
        endDatePicker.pinVertical(to: endDateLabel)
        endDatePicker.pinRight(to: dateBackgroundView.trailingAnchor, 10)
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
        addEventButton.pinTop(to: dateBackgroundView.bottomAnchor, 10)
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
                    showAlertSaveError()
                }
            } else {
                showAlertCreationError()
            }
        } else {
            showAlertInvalidData()
        }
    }
    
    private func showAlertSaveError() {
        let alert = UIAlertController(title: "Data saving error", message: "Failed to save data, please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.alertActionOK, style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlertCreationError() {
        let alert = UIAlertController(title: "Event creation error", message: "Failed to create event, please try again.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.alertActionOK, style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlertInvalidData() {
        let alert = UIAlertController(title: "Invalid data", message: "Please check that you have filled in the title and that the end date is not less than the start date.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.alertActionOK, style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc func valueChanged(sender: UITextField) {
        if let text = titleField.text {
            if (text == "") {
                filteredWishArray = wishArray
            } else {
                filteredWishArray = wishArray.filter({ $0.lowercased().contains(text.lowercased()) })
            }
            tableView.reloadData()
        }
    }
}

// MARK: - UITableViewDataSource
extension WishEventCreationView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredWishArray.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Constants.tableSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.writtenWishReuseId, for: indexPath)
        guard let wishCell = cell as? WrittenWishCell else { return cell }
        wishCell.configure(with: filteredWishArray[indexPath.row])
        return wishCell
    }
}

// MARK: - UITableViewDelegate
extension WishEventCreationView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        titleField.text = filteredWishArray[indexPath.row]
    }
}

// MARK: - UITextFieldDelegate
extension WishEventCreationView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        view.endEditing(true)
        return false
    }
}
