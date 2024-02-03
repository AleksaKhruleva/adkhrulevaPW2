//
//  DateExtension.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 03.02.2024.
//

import UIKit

extension Date {
    var convertedDate: Date {
        let dateFormatter = DateFormatter();
        
        let dateFormat = "yyyy-MM-dd";
        dateFormatter.dateFormat = dateFormat;
        let formattedDate = dateFormatter.string(from: self);
        
        dateFormatter.locale = NSLocale.current;
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00");
        
        dateFormatter.dateFormat = dateFormat as String;
        let sourceDate = dateFormatter.date(from: formattedDate as String);
        
        return sourceDate ?? Date();
    }
}
