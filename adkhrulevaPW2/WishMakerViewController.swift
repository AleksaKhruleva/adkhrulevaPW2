//
//  WishMakerViewController.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 05.10.2023.
//

import UIKit

final class WishMakerViewController: UIViewController {
    
    private let titleView: UILabel = UILabel()
    private let descriptionView: UILabel = UILabel()
    private let button: UIButton = UIButton()
    private let stackView: UIStackView = UIStackView()
    private let addWishButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        
        configureTitle()
        configureDescription()
        
        configureAddWishButton()
        configureSliders()
        configureButton()
    }
    
    private func configureTitle() {
        view.addSubview(titleView)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.appTitle
        titleView.font = UIFont.systemFont(ofSize: Constants.appTitleFS, weight: .heavy)
        //        titleView.textColor = .random()
        titleView.textColor = .black
        
        titleView.pinCenterX(to: view.centerXAnchor)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
        titleView.pinLeft(to: view.leadingAnchor, Constants.titleLeading)
    }
    
    private func configureDescription() {
        view.addSubview(descriptionView)
        
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = Constants.appDescr
        descriptionView.textColor = titleView.textColor
        descriptionView.font = UIFont.systemFont(ofSize: Constants.appDescrFS)
        descriptionView.lineBreakMode = .byWordWrapping
        descriptionView.numberOfLines = Constants.appDescrLineNums
        
        descriptionView.pinCenterX(to: view.centerXAnchor)
        descriptionView.pinTop(to: titleView.bottomAnchor, Constants.descrTop)
        descriptionView.pinLeft(to: view.leadingAnchor, Constants.descrLeading)
    }
    
    private func configureSliders() {
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.layer.cornerRadius = Constants.stackRadius
        stackView.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            slider.tintColor = view.backgroundColor
            stackView.addArrangedSubview(slider)
        }
        
        stackView.setWidth(Constants.stackWidth)
        stackView.pinCenterX(to: view.centerXAnchor)
        stackView.pinBottom(to: addWishButton.topAnchor, Constants.stackBottom)
        
        sliderRed.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: value,
                blue: Double(sliderBlue.slider.value),
                green: Double(sliderGreen.slider.value)
            )
            let oppositeColor = UIColor.oppositeColor(baseColor: self?.view.backgroundColor ?? .white)
            self?.titleView.textColor = oppositeColor
            self?.descriptionView.textColor = oppositeColor
            self?.button.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.button.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.button.backgroundColor = oppositeColor
            self?.addWishButton.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.addWishButton.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.addWishButton.backgroundColor = oppositeColor
            for slider in [sliderRed, sliderGreen, sliderBlue] {
                slider.tintColor = self?.view.backgroundColor
            }
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: Double(sliderRed.slider.value),
                blue: Double(sliderBlue.slider.value),
                green: value)
            let oppositeColor = UIColor.oppositeColor(baseColor: self?.view.backgroundColor ?? .white)
            self?.titleView.textColor = oppositeColor
            self?.descriptionView.textColor = oppositeColor
            self?.button.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.button.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.button.backgroundColor = oppositeColor
            self?.addWishButton.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.addWishButton.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.addWishButton.backgroundColor = oppositeColor
            for slider in [sliderRed, sliderGreen, sliderBlue] {
                slider.tintColor = self?.view.backgroundColor
            }
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self?.view.backgroundColor = UIColor(
                red: Double(sliderRed.slider.value),
                blue: value,
                green: Double(sliderGreen.slider.value)
            )
            let oppositeColor = UIColor.oppositeColor(baseColor: self?.view.backgroundColor ?? .white)
            self?.titleView.textColor = oppositeColor
            self?.descriptionView.textColor = oppositeColor
            self?.button.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.button.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.button.backgroundColor = oppositeColor
            self?.addWishButton.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.addWishButton.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.addWishButton.backgroundColor = oppositeColor
            for slider in [sliderRed, sliderGreen, sliderBlue] {
                slider.tintColor = self?.view.backgroundColor
            }
        }
    }
    
    private func configureButton() {
        view.addSubview(button)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.buttonTextHide, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        button.setTitleColor(view.backgroundColor, for: .normal)
        button.setTitleColor(titleView.textColor, for: .highlighted)
        button.backgroundColor = titleView.textColor
        button.layer.cornerRadius = Constants.buttonRadius
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        button.setHeight(Constants.buttonHeight)
        button.setWidth(Constants.stackWidth)
        button.pinCenterX(to: view.centerXAnchor)
        button.pinBottom(to: stackView.topAnchor, Constants.buttonBottom)
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setTitle(Constants.addWishButtonText, for: .normal)
        addWishButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        addWishButton.setTitleColor(view.backgroundColor, for: .normal)
        addWishButton.setTitleColor(titleView.textColor, for: .highlighted)
        addWishButton.backgroundColor = titleView.textColor
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
        
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.setWidth(Constants.stackWidth)
        addWishButton.pinCenterX(to: view.centerXAnchor)
        addWishButton.pinBottom(to: view, Constants.addWishButtonBottom)
    }
    
    @objc
    private func buttonPressed() {
        stackView.isHidden = !stackView.isHidden
        button.setTitle(stackView.isHidden ? Constants.buttonTextShow : Constants.buttonTextHide, for: .normal)
    }
    
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
}
