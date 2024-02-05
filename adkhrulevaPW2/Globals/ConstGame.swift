//
//  ConstGame.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 06.02.2024.
//

import UIKit

enum ConstGame {
    static let numberOfGroups: Int = 3
    static let offsetCoef: CGFloat = 70
    
    static let red: Int = 0
    static let green: Int = 1
    static let blue: Int = 2
    
    static let rules: String = "The point of the game:\n\ntry to guess sRGB values of the current background color :))"
    static let rulesLabelFS: CGFloat = 20
    static let rulesLabelWidth: CGFloat = 300
    static let rulesLabelTop: CGFloat = 20
    
    static let textFieldFS: CGFloat = 17
    static let textFieldWidth: CGFloat = 80
    static let textFieldTop: CGFloat = 50
    static let textFieldMaxValue: Int = 255
    static let textFieldMinValue: Int = 0
    static let textFieldCharLimit: Int = 3
    static let textFieldStartValue: Int = -1
    
    static let placeholderRed: String = "R"
    static let placeholderGreen: String = "G"
    static let placeholderBlue: String = "B"
    
    static let buttonWidth: CGFloat = 50
    static let buttonSide: CGFloat = 20
    static let buttonCornerRadius: CGFloat = 25
    
    static let incButtonImage: String = "plus"
    static let incButtonValue: Int = 1
    
    static let decButtonImage: String = "minus"
    static let decButtonValue: Int = 1
    
    static let checkButtonTitle: String = "Check"
    static let checkButtonWidth: CGFloat = 220
    static let checkButtonBottom: CGFloat = 140
    static let checkButtonTop: CGFloat = 50
    
    static let verdictLabelFS: CGFloat = 20
    static let verdictLabelWidth: CGFloat = 300
    static let verdictLabelBottom: CGFloat = 50
    
    static let zeroStr: String = "0"
    static let emptyString: String = ""
    
    static let verdictRight: String = "Congratulations, you guessed it right!"
    static let verdictWrong: String = "Unfortunately the answer is wrong"
    
    static let allowedError: Int = 2
}
