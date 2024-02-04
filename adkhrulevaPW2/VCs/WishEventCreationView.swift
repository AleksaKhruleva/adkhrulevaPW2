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
    
    var didAddItem: ((_ item: WishEvent) -> Void)?
    
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
        startDatePicker.addTarget(self, action: #selector(startDPValueChanged), for: .editingDidEnd)
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
        let largeFont = UIFont.systemFont(ofSize: ConstEventCrtn.buttonImageFont, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: ConstEventCrtn.closeButtonImage, withConfiguration: configuration)
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
        titleField.placeholder = ConstEventCrtn.titleFieldPlaceholder
        titleField.returnKeyType = UIReturnKeyType.done
        
        titleField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        titleField.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        titleField.leftViewMode = .always
        titleField.rightViewMode = .always
        
        titleField.setHeight(Constants.buttonHeight)
        titleField.setWidth(Constants.stackWidth)
        titleField.pinCenterX(to: view.centerXAnchor)
        titleField.pinTop(to: closeButton.bottomAnchor, ConstEventCrtn.titleFieldTop)
    }
    
    private func configureHintLable() {
        view.addSubview(hintLabel)
        
        hintLabel.translatesAutoresizingMaskIntoConstraints = false
        hintLabel.text = ConstEventCrtn.hintText
        hintLabel.textColor = .white
        hintLabel.font = UIFont.systemFont(ofSize: ConstEventCrtn.hintFS)
        hintLabel.lineBreakMode = .byWordWrapping
        hintLabel.numberOfLines = .zero
        
        hintLabel.setWidth(Constants.stackWidth)
        hintLabel.pinLeft(to: view.leadingAnchor, ConstEventCrtn.hintLeft)
        hintLabel.pinTop(to: titleField.bottomAnchor, ConstEventCrtn.hintTop)
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
        tableView.setHeight(ConstEventCrtn.tableHeight)
        tableView.pinCenterX(to: view.centerXAnchor)
        tableView.pinTop(to: hintLabel.bottomAnchor, ConstEventCrtn.tableTop)
    }
    
    private func configureNotesField() {
        view.addSubview(notesField)
        
        notesField.translatesAutoresizingMaskIntoConstraints = false
        notesField.backgroundColor = .white
        notesField.layer.cornerRadius = Constants.buttonCornerRadius
        notesField.placeholder = ConstEventCrtn.notesFieldPlaceholder
        notesField.returnKeyType = UIReturnKeyType.done
        
        notesField.leftView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        notesField.rightView = UIView(frame: CGRect(x: .zero, y: .zero, width: Constants.wishFieldViewWidth, height: Constants.wishFieldViewHeight))
        notesField.leftViewMode = .always
        notesField.rightViewMode = .always
        
        notesField.setHeight(Constants.buttonHeight)
        notesField.setWidth(Constants.stackWidth)
        notesField.pinCenterX(to: view.centerXAnchor)
        notesField.pinTop(to: tableView.bottomAnchor, ConstEventCrtn.notesFieldTop)
    }
    
    private func configureDateBackgroundView() {
        view.addSubview(dateBackgroundView)
        dateBackgroundView.addSubview(startDateLabel)
        dateBackgroundView.addSubview(startDatePicker)
        dateBackgroundView.addSubview(endDateLabel)
        dateBackgroundView.addSubview(endDatePicker)
        
        dateBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        dateBackgroundView.backgroundColor = .white
        dateBackgroundView.layer.cornerRadius = ConstEventCrtn.dateBVCornerRadius
        
        dateBackgroundView.setWidth(Constants.stackWidth)
        dateBackgroundView.setHeight(ConstEventCrtn.dateBVHeight)
        dateBackgroundView.pinCenterX(to: view.centerXAnchor)
        dateBackgroundView.pinTop(to: notesField.bottomAnchor, ConstEventCrtn.dateBVTop)
        
        configureStartDateLabel()
        configureStartDatePicker()
        configureEndDateLabel()
        configureEndDatePicker()
    }
    
    private func configureStartDateLabel() {
        startDateLabel.translatesAutoresizingMaskIntoConstraints = false
        startDateLabel.text = ConstEventCrtn.startDateLabelText
        startDateLabel.textColor = .black
        startDateLabel.font = UIFont.systemFont(ofSize: ConstEventCrtn.dateLabelFS)
        
        startDateLabel.pinTop(to: dateBackgroundView.topAnchor, ConstEventCrtn.startDateLabelTop)
        startDateLabel.pinLeft(to: dateBackgroundView.leadingAnchor, ConstEventCrtn.dateLabelLeft)
    }
    
    private func configureStartDatePicker() {
        startDatePicker.translatesAutoresizingMaskIntoConstraints = false
        startDatePicker.datePickerMode = .date
        startDatePicker.minimumDate = Date()
        startDatePicker.calendar = .autoupdatingCurrent
        
        startDatePicker.pinVertical(to: startDateLabel)
        startDatePicker.pinRight(to: dateBackgroundView.trailingAnchor, ConstEventCrtn.datePickerRight)
    }
    
    private func configureEndDateLabel() {
        endDateLabel.translatesAutoresizingMaskIntoConstraints = false
        endDateLabel.text = ConstEventCrtn.endDateLabelText
        endDateLabel.textColor = .black
        endDateLabel.font = UIFont.systemFont(ofSize: ConstEventCrtn.dateLabelFS)
        
        endDateLabel.pinTop(to: startDateLabel.bottomAnchor, ConstEventCrtn.endDateLabelTop)
        endDateLabel.pinLeft(to: dateBackgroundView.leadingAnchor, ConstEventCrtn.dateLabelLeft)
    }
    
    private func configureEndDatePicker() {
        endDatePicker.translatesAutoresizingMaskIntoConstraints = false
        endDatePicker.datePickerMode = .date
        endDatePicker.minimumDate = Date()
        endDatePicker.calendar = .autoupdatingCurrent
        
        endDatePicker.pinVertical(to: endDateLabel)
        endDatePicker.pinRight(to: dateBackgroundView.trailingAnchor, ConstEventCrtn.datePickerRight)
    }
    
    private func configureAddEventButton() {
        view.addSubview(addEventButton)
        
        addEventButton.translatesAutoresizingMaskIntoConstraints = false
        addEventButton.setTitle(ConstEventCrtn.addButtonTitle, for: .normal)
        addEventButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        addEventButton.setTitleColor(view.backgroundColor, for: .normal)
        addEventButton.setTitleColor(.white, for: .highlighted)
        addEventButton.backgroundColor = .white
        addEventButton.layer.cornerRadius = Constants.buttonCornerRadius
        addEventButton.addTarget(self, action: #selector(addEventButtonPressed), for: .touchUpInside)
        
        addEventButton.setHeight(Constants.buttonHeight)
        addEventButton.setWidth(Constants.stackWidth)
        addEventButton.pinCenterX(to: view.centerXAnchor)
        addEventButton.pinTop(to: dateBackgroundView.bottomAnchor, ConstEventCrtn.addButtonTop)
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
            endDateConv = endDateConv.addingTimeInterval(ConstEventCrtn.endDateAddingTime)
            
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
                    didAddItem?(event)
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
        let alert = UIAlertController(title: ConstEventCrtn.saveErrorTitle, message: ConstEventCrtn.saveErrorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.alertActionOK, style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlertCreationError() {
        let alert = UIAlertController(title: ConstEventCrtn.creationErrorTitle, message: ConstEventCrtn.creationErrorMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.alertActionOK, style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func showAlertInvalidData() {
        let alert = UIAlertController(title: ConstEventCrtn.invalidDataTitle, message: ConstEventCrtn.invalidDataMessage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Constants.alertActionOK, style: .default))
        self.present(alert, animated: true, completion: nil)
    }
    
    @objc
    func valueChanged(sender: UITextField) {
        if let text = titleField.text {
            if (text.isEmpty) {
                filteredWishArray = wishArray
            } else {
                filteredWishArray = wishArray.filter({ $0.lowercased().contains(text.lowercased()) })
            }
            tableView.reloadData()
        }
    }
    
    @objc
    private func startDPValueChanged() {
        if (startDatePicker.date > endDatePicker.minimumDate ?? Date()) {
            endDatePicker.minimumDate = startDatePicker.date
            endDatePicker.date = startDatePicker.date
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
