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
        let numberOfGroups = 3
        
        for groupIndex in 0 ..< numberOfGroups {
            let yOffset = CGFloat(groupIndex) * 70
            createElementsGroup(at: yOffset, tag: groupIndex)
        }
        
        configureBackButton()
        configureRulesLabel()
        configureCheckButton()
    }
    
    private func configureBackButton() {
        let largeFont = UIFont.systemFont(ofSize: ConstCalendar.buttonImageFont, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: ConstCalendar.backButtonImage, withConfiguration: configuration)
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem?.tintColor = .black
    }
    
    private func configureRulesLabel() {
        view.addSubview(rulesLabel)
        
        rulesLabel.translatesAutoresizingMaskIntoConstraints = false
        rulesLabel.text = "The point of the game:\n\ntry to guess the exact sRGB values of the current background color :))"
        rulesLabel.textColor = .white
        rulesLabel.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        rulesLabel.lineBreakMode = .byWordWrapping
        rulesLabel.numberOfLines = .zero
        rulesLabel.textAlignment = .center
        
        rulesLabel.setWidth(300)
        rulesLabel.pinCenterX(to: view.centerXAnchor)
        rulesLabel.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
    }
    
    private func createElementsGroup(at yOffset: CGFloat, tag: Int) {
        let tf: UITextField = UITextField()
        tf.tag = tag
        configureTF(textField: tf, at: yOffset)
    }
    
    private func configureTF(textField: UITextField, at yOffset: CGFloat) {
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.backgroundColor = .white
        textField.layer.cornerRadius = Constants.buttonCornerRadius
        textField.text = "0"
        textField.keyboardType = .numberPad
        textField.returnKeyType = UIReturnKeyType.done
        textField.textAlignment = .center
        
        switch (textField.tag) {
        case 0:
            textField.textColor = UIColor.red
            break;
        case 1:
            textField.textColor = UIColor.green
            break;
        case 2:
            textField.textColor = UIColor.blue
            break
        default:
            break;
        }
        
        textField.setHeight(Constants.buttonHeight)
        textField.setWidth(60)
        textField.pinCenterX(to: view.centerXAnchor)
        textField.pinTop(to: view.topAnchor, 230 + yOffset)
        
        let incButton: UIButton = UIButton(type: .system)
        incButton.tag = textField.tag
        view.addSubview(incButton)
        
        configureIB(button: incButton)
        
        incButton.setWidth(50)
        incButton.pinLeft(to: textField.trailingAnchor, 20)
        incButton.pinVertical(to: textField)
        
        let decButton: UIButton = UIButton(type: .system)
        decButton.tag = textField.tag
        view.addSubview(decButton)
        
        configureDB(button: decButton)
        
        decButton.setWidth(50)
        decButton.pinRight(to: textField.leadingAnchor, 20)
        decButton.pinVertical(to: textField)
        
        groupData[incButton.tag] = (textField, incButton, decButton)
    }
    
    private func configureIB(button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeFont = UIFont.systemFont(ofSize: ConstCalendar.buttonImageFont, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "plus", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(incrementButtonPressed(_:)), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 23
    }
    
    private func configureDB(button: UIButton) {
        button.translatesAutoresizingMaskIntoConstraints = false
        let largeFont = UIFont.systemFont(ofSize: ConstCalendar.buttonImageFont, weight: .bold)
        let configuration = UIImage.SymbolConfiguration(font: largeFont)
        let image = UIImage(systemName: "minus", withConfiguration: configuration)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(decrementButtonPressed(_:)), for: .touchUpInside)
        button.backgroundColor = .white
        button.layer.cornerRadius = 23
    }
    
    private func configureCheckButton() {
        view.addSubview(checkButton)
        
        checkButton.translatesAutoresizingMaskIntoConstraints = false
        checkButton.setTitle("Check", for: .normal)
        checkButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        checkButton.setTitleColor(view.backgroundColor, for: .normal)
        checkButton.setTitleColor(.white, for: .highlighted)
        checkButton.backgroundColor = .white
        checkButton.layer.cornerRadius = Constants.buttonCornerRadius
        checkButton.addTarget(self, action: #selector(checkButtonPressed), for: .touchUpInside)
        
        checkButton.setHeight(Constants.buttonHeight)
        checkButton.setWidth(Constants.stackWidth)
        checkButton.pinCenterX(to: view.centerXAnchor)
        checkButton.pinBottom(to: view.bottomAnchor, 100)
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
        var intValue = Int(textField.text ?? "0") ?? 0
        if (intValue < 255) {
            intValue += 1
        }
        textField.text = String(intValue)
    }
    
    @objc
    private func decrementButtonPressed(_ sender: UIButton) {
        let tag = sender.tag
        guard let pair = groupData[tag] else { return }
        let textField = pair.textField
        var intValue = Int(textField.text ?? "0") ?? 0
        if (intValue > 0) {
            intValue -= 1
        }
        textField.text = String(intValue)
    }
    
    @objc
    private func checkButtonPressed() {
        var red: Double? = nil
        var green: Double? = nil
        var blue: Double? = nil
        
        for el in groupData {
            let dop = el.value.textField
            if (dop.tag == 0) {
                red = (Double(dop.text ?? "0") ?? 0.0) / 255
            } else if (dop.tag == 1) {
                green = (Double(dop.text ?? "0") ?? 0.0) / 255
            } else if (dop.tag == 2) {
                blue = (Double(dop.text ?? "0") ?? 0.0) / 255
            }
        }
        
        for el in [red, green, blue] {
            if el == nil {
                return
            }
        }
        
        print(red)
        print(green)
        print(blue)
        
        let a = randomColor.rgb()
        print(a)
        
//        print(randomColor.isEqual(UIColor(red: rgb[0], blue: rgb[1], green: rgb[2])))
    }
}

func getRGB(from color: UIColor) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
    var red: CGFloat = 0
    var green: CGFloat = 0
    var blue: CGFloat = 0

    color.getRed(&red, green: &green, blue: &blue, alpha: nil)
    
    let red255 = red * 255
    let green255 = green * 255
    let blue255 = blue * 255

    return (red: red, green: green, blue: blue)
}
