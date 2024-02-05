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
    private let gameButton: UIButton = UIButton(type: .system)
    private let hideButton: UIButton = UIButton(type: .system)
    private let stackView: UIStackView = UIStackView()
    private let showWishesButton: UIButton = UIButton(type: .system)
    private let scheduleButton: UIButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.isHidden = false
    }
    
    // MARK: - UI Configuration
    private func configureUI() {
        view.backgroundColor = Vars.backgroundColor
        
        configureTitle()
        configureDescription()
        
        configureScheduleButton()
        configureShowWishesButton()
        configureSliders()
        configureHideButton()
        configureGameButton()
    }
    
    private func configureTitle() {
        view.addSubview(titleView)
        
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.appTitle
        titleView.font = UIFont.systemFont(ofSize: Constants.appTitleFS, weight: .heavy)
        titleView.textColor = Vars.textColor
        
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
    
    private func configureGameButton() {
        view.addSubview(gameButton)
        
        gameButton.translatesAutoresizingMaskIntoConstraints = false
        gameButton.setTitle(Constants.gameButtonTitle, for: .normal)
        gameButton.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        gameButton.setTitleColor(titleView.textColor, for: .normal)
        gameButton.setTitleColor(view.backgroundColor, for: .highlighted)
        gameButton.layer.cornerRadius = Constants.buttonCornerRadius
        gameButton.addTarget(self, action: #selector(gameButtonPressed), for: .touchUpInside)
        
        gameButton.setHeight(Constants.buttonHeight)
        gameButton.setWidth(Constants.stackWidth)
        gameButton.pinCenterX(to: view.centerXAnchor)
        gameButton.pinBottom(to: hideButton.topAnchor, Constants.hideButtonBottom)
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
        hideButton.addTarget(self, action: #selector(hideButtonPressed), for: .touchUpInside)
        
        hideButton.setHeight(Constants.buttonHeight)
        hideButton.setWidth(Constants.stackWidth)
        hideButton.pinCenterX(to: view.centerXAnchor)
        hideButton.pinBottom(to: stackView.topAnchor, Constants.hideButtonBottom)
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
            let color = UIColor(red: value, blue: Double(sliderBlue.slider.value), green: Double(sliderGreen.slider.value))
            self?.updateUI(viewBackgroundColor: color)
            for slider in [sliderRed, sliderGreen, sliderBlue] {
                slider.tintColor = self?.view.backgroundColor
            }
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            let color = UIColor(red: Double(sliderRed.slider.value), blue: Double(sliderBlue.slider.value), green: value)
            self?.updateUI(viewBackgroundColor: color)
            for slider in [sliderRed, sliderGreen, sliderBlue] {
                slider.tintColor = self?.view.backgroundColor
            }
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            let color = UIColor(red: Double(sliderRed.slider.value), blue: value, green: Double(sliderGreen.slider.value))
            self?.updateUI(viewBackgroundColor: color)
            for slider in [sliderRed, sliderGreen, sliderBlue] {
                slider.tintColor = self?.view.backgroundColor
            }
        }
    }
    
    private func updateUI(viewBackgroundColor: UIColor) {
        let oppositeColor = UIColor.oppositeColor(baseColor: viewBackgroundColor)
        Vars.backgroundColor = viewBackgroundColor
        Vars.oppositeBackgroundColor = oppositeColor
        view.backgroundColor = viewBackgroundColor
        titleView.textColor = oppositeColor
        descriptionView.textColor = oppositeColor
        for s in stackView.arrangedSubviews {
            s.backgroundColor = oppositeColor
        }
        self.gameButton.setTitleColor(oppositeColor, for: .normal)
        self.gameButton.setTitleColor(viewBackgroundColor, for: .highlighted)
        for button in [self.hideButton, self.showWishesButton, self.scheduleButton] {
            updateButton(
                button: button,
                titleColorNormal: viewBackgroundColor,
                titleColorHighlighted: oppositeColor,
                backgroundColor: oppositeColor
            )
        }
    }
    
    private func updateButton(button: UIButton, titleColorNormal: UIColor, titleColorHighlighted: UIColor, backgroundColor: UIColor) {
        button.setTitleColor(titleColorNormal, for: .normal)
        button.setTitleColor(titleColorHighlighted, for: .highlighted)
        button.backgroundColor = backgroundColor
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
    private func hideButtonPressed() {
        stackView.isHidden.toggle()
        hideButton.setTitle(stackView.isHidden ? Constants.hideButtonTextShow : Constants.hideButtonTextHide, for: .normal)
    }
    
    @objc
    private func showWishesButtonPressed() {
        let oppositeColor = UIColor.oppositeColor(baseColor: view.backgroundColor ?? .random())
        Vars.oppositeBackgroundColor = oppositeColor
        let vc = WishStoringViewController()
        present(vc, animated: true)
    }
    
    @objc
    private func scheduleButtonPressed() {
        let oppositeColor = UIColor.oppositeColor(baseColor: view.backgroundColor ?? .random())
        Vars.oppositeBackgroundColor = oppositeColor
        let vc = WishCalendarViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc
    private func gameButtonPressed() {
        let randomColor = UIColor.random()
        let vc = GameViewController(randomColor: randomColor)
        navigationController?.pushViewController(vc, animated: true)
    }
}
