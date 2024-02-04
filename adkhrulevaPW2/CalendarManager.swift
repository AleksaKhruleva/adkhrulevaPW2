//
//  CalendarService.swift
//  adkhrulevaPW2
//
//  Created by Aleksa Khruleva on 03.02.2024.
//

import EventKit

protocol CalendarManaging {
    func create(eventModel: CalendarEventModel) -> Bool
}

struct CalendarEventModel {
    var title: String
    var note: String?
    var startDate: Date
    var endDate: Date
}

final class CalendarManager: CalendarManaging {
    private let eventStore : EKEventStore = EKEventStore()
    
    func create(eventModel: CalendarEventModel) -> Bool {
        var result: Bool = false
        let group = DispatchGroup()
        group.enter()
        create(eventModel: eventModel) { isCreated in
            result = isCreated
            group.leave()
        }
        group.wait()
        return result
    }
    
    private func create(eventModel: CalendarEventModel, completion: ((Bool) -> Void)?) {
        let createEvent: EKEventStoreRequestAccessCompletionHandler = { [weak self] (granted, error) in
            guard granted, error == nil, let self else {
                completion?(false)
                return
            }
            
            let event: EKEvent = EKEvent(eventStore: self.eventStore)
            event.title = eventModel.title
            event.startDate = eventModel.startDate
            event.endDate = eventModel.endDate
            event.notes = eventModel.note
            event.calendar = self.eventStore.defaultCalendarForNewEvents
            
            do {
                try self.eventStore.save(event, span: .thisEvent)
            } catch let error as NSError {
                print(Constants.fatalError + "\(error.description)")
                completion?(false)
            }
            
            completion?(true)
        }
        
        if #available(iOS 17.0, *) {
            eventStore.requestWriteOnlyAccessToEvents(completion: createEvent)
        } else {
            eventStore.requestAccess(to: .event, completion: createEvent)
        }
    }
}
