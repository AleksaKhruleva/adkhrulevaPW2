//
//  GameViewController.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 05.02.2024.
//

import UIKit

final class GameViewController: UIViewController {
    
    private let rulesLabel: UILabel = UILabel()
    private let checkButton: UIButton = UIButton()
    private let verdictLabel: UILabel = UILabel()
    
    private var groupData: [Int: (textField: UITextField, buttonInc: UIButton, buttonDec: UIButton)] = [:]
    
    private var randomColor: UIColor
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        view.backgroundColor = randomColor
        navigationItem.hidesBackButton = true
        configureUI()
    }
    
    init(randomColor: UIColor) {
        self.randomColor = randomColor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError(Constants.fatalError)
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        configureBackButton()
        configureRulesLabel()
        for groupIndex in .zero ..< ConstGame.numberOfGroups {
            let yOffset = CGFloat(groupIndex) * ConstGame.offsetCoef
            createElementsGroup(at: yOffset, tag: groupIndex)
        }
        configureCheckButton()
        configureVerdictLabel()
    }
    
    private func configureBackButton() {
        let largeFont = UIFont.systemFont(ofSize: ConstCalendar.buttonImageFont, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: ConstCalendar.backButtonImage, withConfiguration: configuration)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .white
    }
    
    private func configureRulesLabel() {
        view.addSubview(rulesLabel)
        
        rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        rulesLabel.text = ConstGame.rules
        rulesLabel.textColor = .white
        rulesLabel.font = UIFont.systemFont(ofSize: ConstGame.rulesLabelFS, weight: .semibold)
        rulesLabel.lineBreakMode = .byWordWrapping
        rulesLabel.numberOfLines = .zero
        rulesLabel.textAlignment = .center
        
        rulesLabel.setWidth(ConstGame.rulesLabelWidth)
        rulesLabel.pinCenterX(to: view.centerXAnchor)
        rulesLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, ConstGame.rulesLabelTop)
    }
    
    private func createElementsGroup(at yOffset: CGFloat, tag: Int) {
        let tf: UITextField = UITextField()
        tf.tag = tag
        tf.delegate = self
        configureTF(textField: tf, at: yOffset)
    }
    
    private func configureTF(textField: UITextField, at yOffset: CGFloat) {
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = Constants.buttonCornerRadius
        textField.keyboardType = .numberPad
        textField.returnKeyType = UIReturnKeyType.done
        textField.textAlignment = .center
        textField.font = .boldSystemFont(ofSize: ConstGame.textFieldFS)
        
        switch (textField.tag) {
        case ConstGame.red:
            textField.placeholder = ConstGame.placeholderRed
            textField.textColor = UIColor.red
            break;
        case ConstGame.green:
            textField.placeholder = ConstGame.placeholderGreen
            textField.textColor = UIColor.green
            break;
        case ConstGame.blue:
            textField.placeholder = ConstGame.placeholderBlue
            textField.textColor = UIColor.blue
            break
        default:
            break;
        }
        
        textField.setHeight(Constants.buttonHeight)
        textField.setWidth(ConstGame.textFieldWidth)
        textField.pinCenterX(to: view.centerXAnchor)
        textField.pinTop(to: rulesLabel.bottomAnchor, ConstGame.textFieldTop + yOffset)
        
        let incButton: UIButton = UIButton(type: .system)
        incButton.tag = textField.tag
        view.addSubview(incButton)
        configureIB(button: incButton)
        incButton.setWidth(ConstGame.buttonWidth)
        incButton.pinLeft(to: textField.trailingAnchor, ConstGame.buttonSide)
        incButton.pinVertical(to: textField)
        
        let decButton: UIButton = UIButton(type: .system)
        decButton.tag = textField.tag
        view.addSubview(decButton)
        configureDB(button: decButton)
        decButton.setWidth(ConstGame.buttonWidth)
        decButton.pinRight(to: textField.leadingAnchor, ConstGame.buttonSide)
        decButton.pinVertical(to: textField)
        
        groupData[textField.tag] = (textField, incButton, decButton)
    }
    
    private func configureIB(button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeFont = UIFont.systemFont(ofSize: ConstCalendar.buttonImageFont, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: ConstGame.incButtonImage, withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = view.backgroundColor
        button.addTarget(self, action: #selector(incrementButtonPressed(_:)), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = ConstGame.buttonCornerRadius
    }
    
    private func configureDB(button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeFont = UIFont.systemFont(ofSize: ConstCalendar.buttonImageFont, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: ConstGame.decButtonImage, withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.tintColor = view.backgroundColor
        button.addTarget(self, action: #selector(decrementButtonPressed(_:)), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = ConstGame.buttonCornerRadius
    }
    
    private func configureCheckButton() {
        view.addSubview(checkButton)
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.setTitle(ConstGame.checkButtonTitle, for: .normal)
        checkButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        checkButton.setTitleColor(view.backgroundColor, for: .normal)
        checkButton.setTitleColor(.white, for: .highlighted)
        checkButton.backgroundColor = .white
        checkButton.layer.cornerRadius = Constants.buttonCornerRadius
        checkButton.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        
        checkButton.setHeight(Constants.buttonHeight)
        checkButton.setWidth(ConstGame.checkButtonWidth)
        checkButton.pinCenterX(to: view.centerXAnchor)
        
        guard let g = groupData[ConstGame.blue] else {
            checkButton.pinBottom(to: view.bottomAnchor, ConstGame.checkButtonBottom)
            return
        }
        checkButton.pinTop(to: g.textField.bottomAnchor, ConstGame.checkButtonTop)
    }
    
    private func configureVerdictLabel() {
        view.addSubview(verdictLabel)
        
        verdictLabel.translatesAutoresizingMaskIntoConstraints = false
        verdictLabel.textColor = .white
        verdictLabel.font = UIFont.systemFont(ofSize: ConstGame.verdictLabelFS, weight: .semibold)
        verdictLabel.lineBreakMode = .byWordWrapping
        verdictLabel.numberOfLines = .zero
        verdictLabel.textAlignment = .center
        
        verdictLabel.setWidth(ConstGame.verdictLabelWidth)
        verdictLabel.pinCenterX(to: view.centerXAnchor)
        verdictLabel.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, ConstGame.verdictLabelBottom)
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func incrementButtonPressed(_ sender: UIButton) {
        let tag = sender.tag
        guard let pair = groupData[tag] else { return }
        let textField = pair.textField
        guard let text = textField.text else { return }
        var intValue = Int(text) ?? ConstGame.textFieldStartValue
        if (intValue < ConstGame.textFieldMaxValue) {
            intValue += ConstGame.incButtonValue
        }
        textField.text = String(intValue)
    }
    
    @objc
    private func decrementButtonPressed(_ sender: UIButton) {
        let tag = sender.tag
        guard let pair = groupData[tag] else { return }
        let textField = pair.textField
        guard let text = textField.text else { return }
        if text.isEmpty { return }
        var intValue = Int(text) ?? .zero
        if (intValue > ConstGame.textFieldMinValue) {
            intValue -= ConstGame.decButtonValue
            textField.text = String(intValue)
        } else if (intValue == .zero) {
            textField.text = ConstGame.emptyString
        }
    }
    
    @objc
    private func checkButtonPressed() {
        var red: Int? = nil
        var green: Int? = nil
        var blue: Int? = nil
        
        for el in groupData {
            let dop = el.value.textField
            if (dop.tag == ConstGame.red) {
                red = (Int(dop.text ?? ConstGame.zeroStr) ?? .zero)
            } else if (dop.tag == ConstGame.green) {
                green = (Int(dop.text ?? ConstGame.zeroStr) ?? .zero)
            } else if (dop.tag == ConstGame.blue) {
                blue = (Int(dop.text ?? ConstGame.zeroStr) ?? .zero)
            }
        }
        
        for el in [red, green, blue] {
            if el == nil { return }
        }
        
        let a = randomColor.getSRGBValues(from: randomColor)
        
        if abs((red ?? .zero) - a.red) <= ConstGame.allowedError
            && abs((green ?? .zero) - a.green) <= ConstGame.allowedError
            && abs((blue ?? .zero) - a.blue) <= ConstGame.allowedError {
            verdictLabel.text = ConstGame.verdictRight
        } else {
            verdictLabel.text = ConstGame.verdictWrong
        }
    }
}

extension GameViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if string.isEmpty {
            return true
        }
        let newLength = (textField.text?.count ?? .zero) + string.count - range.length
        return newLength <= ConstGame.textFieldCharLimit
    }
}
