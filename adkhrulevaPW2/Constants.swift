//
//  Constants.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 05.10.2023.
//

import Foundation
import UIKit

enum Constants {
    static let appTitle: String = "WishMaker"
    static let appDescr: String = "A magical application that will fulfill any of your color wishes"
    
    static let appTitleFS: CGFloat = 32
    static let appDescrFS: CGFloat = 25
    static let appDescrLineNums: Int = 3
    
    static let red: String = "Red"
    static let blue: String = "Blue"
    static let green: String = "Green"
    
    static let titleTop: CGFloat = 30
    static let titleLeading: CGFloat = 20
    
    static let descrTop: CGFloat = 20
    static let descrLeading: CGFloat = 20
    
    static let buttonWidthMult: Double = 0.7
    static let buttonHeight: Double = 50
    static let buttonRadius: CGFloat = 20
    static let buttonBottom: CGFloat = 20
    static let buttonTextShow: String = "Show sliders"
    static let buttonTextHide: String = "Hide sliders"
    static let buttonTitleFS: CGFloat = 20
    
    static let sliderTitleTop: CGFloat = 10
    static let sliderTitleLeading: CGFloat = 20
    static let sliderBottom: CGFloat = -10
    static let sliderLeading: CGFloat = 20
    static let sliderMin: Double = 0
    static let sliderMax: Double = 1
    
    static let stackBottom: CGFloat = 20
    static let stackLeading: CGFloat = 20
    static let stackRadius: CGFloat = 20
    static let stackWidth: CGFloat = UIScreen.main.bounds.width / 1.1
    
    static let addWishButtonText: String = "My wishes"
    static let addWishButtonBottom: CGFloat = 50
    
    static let colorRange: ClosedRange<CGFloat> = 0...1
    static let opacity: Double = 1.0
    
    static let fatalError: String = "init(coder:) has not been implemented"
}
