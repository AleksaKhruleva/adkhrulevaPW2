//
//  UIColorExtension.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 05.10.2023.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Double, blue: Double, green: Double) {
        self.init(
            red: CGFloat(red),
            green: CGFloat(green),
            blue: CGFloat(blue),
            alpha: Constants.opacity
        )
    }
    static func random() -> UIColor {
        return UIColor(
            displayP3Red: .random(in: Constants.colorRange),
            green: .random(in: Constants.colorRange),
            blue: .random(in: Constants.colorRange),
            alpha: Constants.opacity
        )
    }
    static func oppositeColor(baseColor: UIColor) -> UIColor {
        var fRed : CGFloat = .zero
        var fGreen : CGFloat = .zero
        var fBlue : CGFloat = .zero
        var fAlpha: CGFloat = .zero
        
        if baseColor.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            return UIColor(
                red: Constants.sliderMax - fRed,
                green: Constants.sliderMax - fGreen,
                blue: Constants.sliderMax - fBlue,
                alpha: Constants.opacity)
        } else {
            return .white
        }
    }
}
