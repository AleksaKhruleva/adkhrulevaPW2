//
//  WishMakerViewController.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 05.10.2023.
//

import UIKit

final class WishMakerViewController: UIViewController {
    
    private var titleView = UILabel()
    private var descriptionView = UILabel()
    private var button = UIButton()
    private var stackView = UIStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemPink
        
        configureTitle()
        configureDescription()
        configureSliders()
        configureButton()
    }
    
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.appTitle
        titleView.font = UIFont.systemFont(ofSize: Constants.appTitleFS, weight: .heavy)
        titleView.textColor = .random()
        
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.titleLeading),
        ])
    }
    
    private func configureDescription() {
        descriptionView.translatesAutoresizingMaskIntoConstraints = false
        descriptionView.text = Constants.appDescr
        descriptionView.textColor = titleView.textColor
        descriptionView.font = UIFont.systemFont(ofSize: Constants.appDescrFS)
        descriptionView.lineBreakMode = .byWordWrapping
        descriptionView.numberOfLines = Constants.appDescrLineNums
        
        view.addSubview(descriptionView)
        NSLayoutConstraint.activate([
            descriptionView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            descriptionView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: Constants.descrTop),
            descriptionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.descrLeading),
        ])
    }
    
    private func configureSliders() {
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        
        view.addSubview(stackView)
        stackView.layer.cornerRadius = Constants.stackRadius
        stackView.clipsToBounds = true
        
        let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            slider.tintColor = view.backgroundColor
            stackView.addArrangedSubview(slider)
        }
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.stackBottom),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Constants.stackLeading),
        ])
        
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
            for slider in [sliderRed, sliderGreen, sliderBlue] {
                slider.tintColor = self?.view.backgroundColor
            }
        }
    }
    
    private func configureButton() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Constants.buttonTextHide, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: Constants.buttonTitleFS, weight: .bold)
        button.setTitleColor(view.backgroundColor, for: .normal)
        button.setTitleColor(titleView.textColor, for: .highlighted)
        button.backgroundColor = titleView.textColor
        button.layer.cornerRadius = Constants.buttonRadius
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: Constants.buttonWidthMult),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: Constants.buttonBottom),
        ])
    }
    
    @objc
    func buttonAction() {
        stackView.isHidden = !stackView.isHidden
        button.setTitle(stackView.isHidden ? Constants.buttonTextShow : Constants.buttonTextHide, for: .normal)
    }
}
