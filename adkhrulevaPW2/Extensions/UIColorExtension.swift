//
//  UIColorExtension.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 05.10.2023.
//

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
    
    func getSRGBValues(from color: UIColor) -> (red: Int, green: Int, blue: Int) {
        var fRed: CGFloat = .zero
        var fGreen: CGFloat = .zero
        var fBlue: CGFloat = .zero
        var fAlpha: CGFloat = .zero
        if color.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let red = Int(max(.zero, min(fRed * 255.0 + 0.5, 255.0)))
            let green = Int(max(.zero, min(fGreen * 255.0 + 0.5, 255.0)))
            let blue = Int(max(.zero, min(fBlue * 255.0 + 0.5, 255.0)))
            
            return (red: red, green: green, blue: blue)
        } else {
            return (red: .zero, green: .zero, blue: .zero)
        }
    }
}
