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
    private let hideButton: UIButton = UIButton(type: .system)
    private let stackView: UIStackView = UIStackView()
    private let showWishesButton: UIButton = UIButton(type: .system)
    private let scheduleButton: UIButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        
        configureTitle()
        configureDescription()
        
        configureScheduleButton()
        configureShowWishesButton()
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
        stackView.pinBottom(to: showWishesButton.topAnchor, Constants.stackBottom)
        
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
            self?.showWishesButton.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.showWishesButton.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.showWishesButton.backgroundColor = oppositeColor
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
            self?.showWishesButton.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.showWishesButton.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.showWishesButton.backgroundColor = oppositeColor
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
            self?.showWishesButton.setTitleColor(self?.view.backgroundColor ?? .white, for: .normal)
            self?.showWishesButton.setTitleColor(self?.titleView.textColor, for: .highlighted)
            self?.showWishesButton.backgroundColor = oppositeColor
            for slider in [sliderRed, sliderGreen, sliderBlue] {
                slider.tintColor = self?.view.backgroundColor
            }
        }
    }
    
    private func configureHideButton() {
        view.addSubview(hideButton)
        
        hideButton.translatesAutoresizingMaskIntoConstraints = false
        hideButton.setTitle(Constants.hideButtonTextHide, for: .normal)
        hideButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        hideButton.setTitleColor(view.backgroundColor, for: .normal)
        hideButton.setTitleColor(titleView.textColor, for: .highlighted)
        hideButton.backgroundColor = titleView.textColor
        hideButton.layer.cornerRadius = Constants.buttonCornerRadius
        hideButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        
        hideButton.setHeight(Constants.buttonHeight)
        hideButton.setWidth(Constants.stackWidth)
        hideButton.pinCenterX(to: view.centerXAnchor)
        hideButton.pinBottom(to: stackView.topAnchor, Constants.hideButtonBottom)
    }
    
    private func configureShowWishesButton() {
        view.addSubview(showWishesButton)
        
        showWishesButton.translatesAutoresizingMaskIntoConstraints = false
        showWishesButton.setTitle(Constants.showWishesButtonText, for: .normal)
        showWishesButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        showWishesButton.setTitleColor(view.backgroundColor, for: .normal)
        showWishesButton.setTitleColor(titleView.textColor, for: .highlighted)
        showWishesButton.backgroundColor = titleView.textColor
        showWishesButton.layer.cornerRadius = Constants.buttonCornerRadius
        showWishesButton.addTarget(self, action: #selector(showWishesButtonPressed), for: .touchUpInside)
        
        showWishesButton.setHeight(Constants.buttonHeight)
        showWishesButton.setWidth(Constants.stackWidth)
        showWishesButton.pinCenterX(to: view.centerXAnchor)
        showWishesButton.pinBottom(to: scheduleButton.topAnchor, Constants.showWishesButtonBottom)
    }
    
    private func configureScheduleButton() {
        view.addSubview(scheduleButton)
        
        scheduleButton.translatesAutoresizingMaskIntoConstraints = false
        scheduleButton.setTitle(Constants.scheduleButtonText, for: .normal)
        scheduleButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        scheduleButton.setTitleColor(view.backgroundColor, for: .normal)
        scheduleButton.setTitleColor(titleView.textColor, for: .highlighted)
        scheduleButton.backgroundColor = titleView.textColor
        scheduleButton.layer.cornerRadius = Constants.buttonCornerRadius
        scheduleButton.addTarget(self, action: #selector(scheduleButtonPressed), for: .touchUpInside)
        
        scheduleButton.setHeight(Constants.buttonHeight)
        scheduleButton.setWidth(Constants.stackWidth)
        scheduleButton.pinCenterX(to: view.centerXAnchor)
        scheduleButton.pinBottom(to: view, Constants.scheduleButtonBottom)
    }
    
    @objc
    private func buttonPressed() {
        stackView.isHidden = !stackView.isHidden
        hideButton.setTitle(stackView.isHidden ? Constants.hideButtonTextShow : Constants.hideButtonTextHide, for: .normal)
    }
    
    @objc
    private func showWishesButtonPressed() {
        let oppositeColor = UIColor.oppositeColor(baseColor: view.backgroundColor ?? .random())
        let vc = WishStoringViewController(backgroundColor: oppositeColor)
        present(vc, animated: true)
    }
    
    @objc
    private func scheduleButtonPressed() {
    }
}
