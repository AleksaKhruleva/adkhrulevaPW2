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
    
    static let buttonHeight: Double = 50
    static let buttonCornerRadius: CGFloat = 20
    static let buttonTitleFS: CGFloat = 20
    
    static let hideButtonBottom: CGFloat = 20
    static let hideButtonTextShow: String = "Show sliders"
    static let hideButtonTextHide: String = "Hide sliders"
    
    static let sliderTitleTop: CGFloat = 10
    static let sliderTitleLeading: CGFloat = 20
    static let sliderBottom: CGFloat = 10
    static let sliderLeading: CGFloat = 20
    static let sliderMin: Double = 0
    static let sliderMax: Double = 1
    
    static let stackBottom: CGFloat = 20
    static let stackLeading: CGFloat = 20
    static let stackRadius: CGFloat = 20
    static let stackWidth: CGFloat = UIScreen.main.bounds.width / 1.1
    
    static let showWishesButtonText: String = "My wishes"
    static let showWishesButtonBottom: CGFloat = 50
    
    static let closeButtonText: String = "Close"
    static let closeButtonTitleFS: CGFloat = 16
    static let closeButtonTop: CGFloat = 15
    static let closeButtonTrailing: CGFloat = 20
    
    static let tableSections: Int = 1
    static let sectionZero: Int = 0
    static let sectionZeroRows: Int = 1
    static let sectionOne: Int = 1
    
    static let tableCornerRadius: CGFloat = 16
    static let tableTop: CGFloat = 10
    static let tableBottom: CGFloat = 40
    static let tableHorizontal: CGFloat = 10
    static let tableRowHeight: CGFloat = 80
    
    static let writtenWishReuseId: String = "WrittenWishCell"
    
    static let cellWrapOffsetV: CGFloat = 10
    static let cellWrapOffsetH: CGFloat = 20
    
    static let wishFieldPlaceholder: String = "I wish..."
    static let wishFieldViewWidth: CGFloat = 20
    static let wishFieldViewHeight: CGFloat = 60
    static let wishFieldTop: CGFloat = 10
    
    static let wishLabelWidthMult: Double = 1.1
    
    static let addWishButtonText: String = "Add wish"
    static let addWishButtonTop: CGFloat = 10
    
    static let likeButtonImageNormal: String = "heart"
    static let likeButtonTintColor: UIColor = .systemPink
    static let likeButtonRight: CGFloat = 10
    
    static let colorRange: ClosedRange<CGFloat> = 0...1
    static let opacity: Double = 1.0
    
    static let fatalError: String = "init(coder:) has not been implemented"
}
