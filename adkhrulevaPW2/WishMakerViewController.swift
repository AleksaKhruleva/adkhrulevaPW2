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
    private let hideButton: UIButton = UIButton()
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
        configureHideButton()
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
            self?.hideButton.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.hideButton.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.hideButton.backgroundColor = oppositeColor
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
            self?.hideButton.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.hideButton.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.hideButton.backgroundColor = oppositeColor
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
            self?.hideButton.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.hideButton.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.hideButton.backgroundColor = oppositeColor
            self?.addWishButton.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.addWishButton.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.addWishButton.backgroundColor = oppositeColor
            for slider in [sliderRed, sliderGreen, sliderBlue] {
                slider.tintColor = self?.view.backgroundColor
            }
        }
    }
    
    private func configureHideButton() {
        view.addSubview(hideButton)
        
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.setTitle(Constants.hideButtonTextHide, for: .normal)
        hideButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.hideButtonTitleFS, weight: .bold)
        hideButton.setTitleColor(view.backgroundColor, for: .normal)
        hideButton.setTitleColor(titleView.textColor, for: .highlighted)
        hideButton.backgroundColor = titleView.textColor
        hideButton.layer.cornerRadius = Constants.hideButtonRadius
        hideButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        hideButton.setHeight(Constants.hideButtonHeight)
        hideButton.setWidth(Constants.stackWidth)
        hideButton.pinCenterX(to: view.centerXAnchor)
        hideButton.pinBottom(to: stackView.topAnchor, Constants.hideButtonBottom)
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        
        addWishButton.translatesAutoresizingMaskIntoConstraints = false
        addWishButton.setTitle(Constants.addWishButtonText, for: .normal)
        addWishButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.hideButtonTitleFS, weight: .bold)
        addWishButton.setTitleColor(view.backgroundColor, for: .normal)
        addWishButton.setTitleColor(titleView.textColor, for: .highlighted)
        addWishButton.backgroundColor = titleView.textColor
        addWishButton.layer.cornerRadius = Constants.hideButtonRadius
        addWishButton.addTarget(self, action: #selector(showWishesButtonPressed), for: .touchUpInside)
        
        addWishButton.setHeight(Constants.hideButtonHeight)
        addWishButton.setWidth(Constants.stackWidth)
        addWishButton.pinCenterX(to: view.centerXAnchor)
        addWishButton.pinBottom(to: view, Constants.addWishButtonBottom)
    }
    
    @objc
    private func buttonPressed() {
        stackView.isHidden = !stackView.isHidden
        hideButton.setTitle(stackView.isHidden ? Constants.hideButtonTextShow : Constants.hideButtonTextHide, for: .normal)
    }
    
    @objc
    private func showWishesButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
}
