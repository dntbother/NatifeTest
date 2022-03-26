//
//  DateService.swift
//  NatifeTest
//
//  Created by Mykhailo Petukhov on 26.03.2022.
//

import Foundation

class DateService {
    lazy private var uaCalendar: Calendar = {
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: "ru_UA")
        return calendar
    }()
    lazy private var displayDateComponentsFormatter: DateComponentsFormatter = {
        let dateCompFormatter = DateComponentsFormatter()
        dateCompFormatter.calendar = uaCalendar
        dateCompFormatter.allowedUnits = [.year, .month, .day]
        dateCompFormatter.unitsStyle = .brief
        
        return dateCompFormatter
    }()
    
    func getDifferenceBetween(unixEpoch: Double, and date: Date) -> TimeInterval {
        let postDate = unixEpoch.convertUnixEpochToDate()
        let diff = date.timeIntervalSince(postDate)
        
        return diff
    }
    
    func getDateStringFrom(timeInterval: TimeInterval) -> String? {
        if let dateString = displayDateComponentsFormatter.string(from: timeInterval) {
            return dateString
        } else {
            return nil
        }
    }
}
