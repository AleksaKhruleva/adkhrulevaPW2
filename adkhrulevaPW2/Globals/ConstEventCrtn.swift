//
//  ConstEventCrtn.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 04.02.2024.
//

import UIKit

enum ConstEventCrtn {
    static let closeButtonImage: String = "xmark"
    static let buttonImageFont: CGFloat = 20
    
    static let titleFieldPlaceholder: String = "Title"
    static let titleFieldTop: CGFloat = 10
    
    static let hintText: String = "Come up with a new wish or select from saved ones:"
    static let hintFS: CGFloat = 17
    static let hintLeft: CGFloat = 25
    static let hintTop: CGFloat = 10
    
    static let tableHeight: CGFloat = 122
    static let tableTop: CGFloat = 10
    
    static let notesFieldPlaceholder: String = "Notes (optional)"
    static let notesFieldTop: CGFloat = 10
    
    static let dateBVCornerRadius: CGFloat = 20
    static let dateBVHeight: CGFloat = 99
    static let dateBVTop: CGFloat = 10
    
    static let dateLabelFS: CGFloat = 17
    static let dateLabelLeft: CGFloat = 20
    
    static let datePickerRight: CGFloat = 20
    
    static let startDateLabelText: String = "Start date:"
    static let startDateLabelTop: CGFloat = 10
    
    static let endDateLabelText: String = "End date:"
    static let endDateLabelTop: CGFloat = 10
    
    static let addButtonTitle: String = "Add event"
    static let addButtonTop: CGFloat = 10
    
    static let endDateAddingTime: Double = 23 * 60 * 60 + 59 * 60
    
    static let saveErrorTitle: String = "Data saving error"
    static let saveErrorMessage: String = "Failed to save data, please try again."
    
    static let creationErrorTitle: String = "Event creation error"
    static let creationErrorMessage: String = "Failed to create event, please try again."
    
    static let invalidDataTitle: String = "Invalid data"
    static let invalidDataMessage: String = "Please check that you have filled in the title."
}
