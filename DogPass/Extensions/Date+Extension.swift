//
//  Date+RawPresentable.swift
//  DogPass
//
//  Created by Marius Preikschat on 09.03.23.
//

import Foundation

extension Date: RawRepresentable {
    public var rawValue: String {
        self.timeIntervalSinceReferenceDate.description
    }

    public init?(rawValue: String) {
        self = Date(timeIntervalSinceReferenceDate: Double(rawValue) ?? 0.0)
    }
}

extension Date {
    var formatted: String {
        let dateFormatterOut = DateFormatter()
        dateFormatterOut.dateStyle = .long
        dateFormatterOut.timeStyle = .none
        return dateFormatterOut.string(from: self)
    }

    var translateDogBirthdayToHumanYears: (age: String, humanAge: String) {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .month, .year], from: self, to: Date.now)
        let yearsDifference = components.year!
        let monthsDifference = components.month!
        let daysDifference = components.day!
        var year = ""
        var month = ""
        var day = ""
        let years = yearsDifference > 0
        let months = monthsDifference > 0
        let days = daysDifference > 0

        if years {
            year = "\(yearsDifference) \(yearsDifference == 1 ? "Jahr" : "Jahre")"
        }

        if months {
            month = "\(years ? " " : "")\(monthsDifference) \(monthsDifference == 1 ? "Monat" : "Monate")"
        }
        if days {
            day = "\(months ? " " : "")\(daysDifference) \(daysDifference == 1 ? "Tag" : "Tage")"
        }

        return ("\(year)\(month)\(day)", "\(yearsDifference.calculateHumanAge) Menschenjahre")
    }

    var calucateDaysUntil: Int {
        let calendar = Calendar.current
        var days = calendar.dateComponents([.day], from: Date.now, to: self).day ?? -999
        if days == 0 && !calendar.isDateInToday(self) {
            days = 1
        }
        return days
    }

    var calucateDaysUntilInDays: String {
        let days = self.calucateDaysUntil
        return "\(days) \(days == 1 ? "Tag" : "Tagen")"
    }

    var calculateDaysUntilBirthday: String {
        let calendar = Calendar.current
        let today = "🍾 Heute 🎉"
        if calendar.isDateInToday(self) {
            return today
        }

        let dateNow = Date.now
        var dcs = DateComponents()

        let birthdayComponents = calendar.dateComponents([.day, .month, .year, .hour, .minute, .second], from: self)
        let todayComponents = calendar.dateComponents([.year, .day], from: dateNow)

        dcs.hour = birthdayComponents.hour
        dcs.minute = birthdayComponents.minute
        dcs.second = birthdayComponents.second
        dcs.day = birthdayComponents.day
        dcs.month = birthdayComponents.month
        dcs.year = todayComponents.year

        var birthday = calendar.date(from: dcs)

        var components = calendar.dateComponents([.day], from: dateNow, to: birthday!)
        var daysDifference = components.day!

        if daysDifference == 0 && birthday! > dateNow {
            daysDifference = 1
        }

        if daysDifference < 0 {
            dcs.year! += 1
            birthday = calendar.date(from: dcs)
            components = calendar.dateComponents([.day], from: dateNow, to: birthday!)
            daysDifference = components.day!
        }

        let suffix = daysDifference == 1 ? "Tag" : "Tagen"

        return daysDifference == 0 ? today : "Geburtstag in \(daysDifference) \(suffix) 🎉"
    }
}
