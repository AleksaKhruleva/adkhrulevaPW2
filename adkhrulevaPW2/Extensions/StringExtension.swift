//
//  StringExtension.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 03.02.2024.
//

import UIKit

extension String {
    var beautifulStringDate: String {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
        
        let dateFormatterPrint = DateFormatter()
        dateFormatterPrint.dateFormat = "dd.MM.yyyy"
        
        let date: Date? = dateFormatterGet.date(from: self)
        return dateFormatterPrint.string(from: date ?? Date())
    }
}
