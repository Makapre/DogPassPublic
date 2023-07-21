//
//  Date+Extension.swift
//  DogPassTests
//
//  Created by Marius Preikschat on 24.05.23.
//

@testable import DogPass
import XCTest

final class DateExtension: XCTestCase {
    lazy var today: Date = {
        return Date.now
    }()

    lazy var birthdayMinus1Day: Date = {
        var dcs = DateComponents()

        let birthdayComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: today)
        dcs.day = birthdayComponents.day! - 1
        dcs.month = birthdayComponents.month
        dcs.year = birthdayComponents.year
        dcs.hour = birthdayComponents.hour
        dcs.minute = birthdayComponents.minute
        dcs.second = birthdayComponents.second
        return Calendar.current.date(from: dcs)!
    }()

    lazy var birthdayMinus1Year: Date = {
        var dcs = DateComponents()

        let birthdayComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: today)
        dcs.day = birthdayComponents.day
        dcs.month = birthdayComponents.month
        dcs.year = birthdayComponents.year! - 1
        dcs.hour = birthdayComponents.hour
        dcs.minute = birthdayComponents.minute
        dcs.second = birthdayComponents.second
        return Calendar.current.date(from: dcs)!
    }()

    lazy var birthdayMinus2Year: Date = {
        var dcs = DateComponents()

        let birthdayComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: today)
        dcs.day = birthdayComponents.day
        dcs.month = birthdayComponents.month
        dcs.year = birthdayComponents.year! - 2
        dcs.hour = birthdayComponents.hour
        dcs.minute = birthdayComponents.minute
        dcs.second = birthdayComponents.second
        return Calendar.current.date(from: dcs)!
    }()

    lazy var birthdayMinus3Year: Date = {
        var dcs = DateComponents()

        let birthdayComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: today)
        dcs.day = birthdayComponents.day
        dcs.month = birthdayComponents.month
        dcs.year = birthdayComponents.year! - 3
        dcs.hour = birthdayComponents.hour
        dcs.minute = birthdayComponents.minute
        dcs.second = birthdayComponents.second
        return Calendar.current.date(from: dcs)!
    }()

    lazy var birthdayMinus4Year: Date = {
        var dcs = DateComponents()

        let birthdayComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: today)
        dcs.day = birthdayComponents.day
        dcs.month = birthdayComponents.month
        dcs.year = birthdayComponents.year! - 4
        dcs.hour = birthdayComponents.hour
        dcs.minute = birthdayComponents.minute
        dcs.second = birthdayComponents.second
        return Calendar.current.date(from: dcs)!
    }()

    lazy var birthdayPlus1Day: Date = {
        var dcs = DateComponents()

        let birthdayComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: today)
        dcs.day = birthdayComponents.day! + 1
        dcs.month = birthdayComponents.month
        dcs.year = birthdayComponents.year
        dcs.hour = birthdayComponents.hour
        dcs.minute = birthdayComponents.minute
        dcs.second = birthdayComponents.second
        return Calendar.current.date(from: dcs)!
    }()

    lazy var birthdayPlus1Month: Date = {
        var dcs = DateComponents()

        let birthdayComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: today)
        dcs.day = birthdayComponents.day! - 5
        dcs.month = birthdayComponents.month! + 1
        dcs.year = birthdayComponents.year! - 1
        dcs.hour = birthdayComponents.hour
        dcs.minute = birthdayComponents.minute
        dcs.second = birthdayComponents.second
        return Calendar.current.date(from: dcs)!
    }()

    lazy var birthdayMinus1Month: Date = {
        var dcs = DateComponents()

        let birthdayComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: today)
        dcs.day = birthdayComponents.day! - 5
        dcs.month = birthdayComponents.month! - 1
        dcs.year = birthdayComponents.year
        dcs.hour = birthdayComponents.hour
        dcs.minute = birthdayComponents.minute
        dcs.second = birthdayComponents.second
        return Calendar.current.date(from: dcs)!
    }()

    lazy var birthdayMinus2Month: Date = {
        var dcs = DateComponents()

        let birthdayComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: today)
        dcs.day = birthdayComponents.day! - 5
        dcs.month = birthdayComponents.month! - 2
        dcs.year = birthdayComponents.year
        dcs.hour = birthdayComponents.hour
        dcs.minute = birthdayComponents.minute
        dcs.second = birthdayComponents.second
        return Calendar.current.date(from: dcs)!
    }()

    lazy var birthdayAll: Date = {
        var dcs = DateComponents()

        let birthdayComponents = Calendar.current.dateComponents([.day, .month, .year, .hour, .minute, .second], from: today)
        dcs.day = birthdayComponents.day! - 5
        dcs.month = birthdayComponents.month! - 2
        dcs.year = birthdayComponents.year! - 3
        dcs.hour = birthdayComponents.hour
        dcs.minute = birthdayComponents.minute
        dcs.second = birthdayComponents.second
        return Calendar.current.date(from: dcs)!
    }()

    func testCalculateDaysUntilBirthday() throws {
        XCTAssertEqual("Geburtstag in 1 Tag 🎉", birthdayPlus1Day.calculateDaysUntilBirthday)
        XCTAssertEqual("🍾 Heute 🎉", birthdayMinus1Year.calculateDaysUntilBirthday)
        XCTAssertEqual("🍾 Heute 🎉", today.calculateDaysUntilBirthday)
        XCTAssertEqual("Geburtstag in 364 Tagen 🎉", birthdayMinus1Day.calculateDaysUntilBirthday)
    }

    func testTranslateDogBirthdayToHumanYears() throws {
        XCTAssertEqual("", today.translateDogBirthdayToHumanYears.age)
        XCTAssertEqual("1 Tag", birthdayMinus1Day.translateDogBirthdayToHumanYears.age)
        XCTAssertEqual("1 Jahr", birthdayMinus1Year.translateDogBirthdayToHumanYears.age)
        XCTAssertEqual("2 Jahre", birthdayMinus2Year.translateDogBirthdayToHumanYears.age)
        XCTAssertEqual("3 Jahre", birthdayMinus3Year.translateDogBirthdayToHumanYears.age)
        XCTAssertEqual("4 Jahre", birthdayMinus4Year.translateDogBirthdayToHumanYears.age)
        XCTAssertEqual("1 Monat \(helper(date: birthdayMinus1Month))", birthdayMinus1Month.translateDogBirthdayToHumanYears.age)
        XCTAssertEqual("2 Monate \(helper(date: birthdayMinus2Month))", birthdayMinus2Month.translateDogBirthdayToHumanYears.age)
        XCTAssertEqual("11 Monate \(helper(date: birthdayPlus1Month))", birthdayPlus1Month.translateDogBirthdayToHumanYears.age)
        XCTAssertEqual("3 Jahre 2 Monate \(helper(date: birthdayAll))", birthdayAll.translateDogBirthdayToHumanYears.age)

        XCTAssertEqual("0 Menschenjahre", today.translateDogBirthdayToHumanYears.humanAge)
        XCTAssertEqual("0 Menschenjahre", birthdayMinus1Day.translateDogBirthdayToHumanYears.humanAge)
        XCTAssertEqual("15 Menschenjahre", birthdayMinus1Year.translateDogBirthdayToHumanYears.humanAge)
        XCTAssertEqual("24 Menschenjahre", birthdayMinus2Year.translateDogBirthdayToHumanYears.humanAge)
        XCTAssertEqual("29 Menschenjahre", birthdayMinus3Year.translateDogBirthdayToHumanYears.humanAge)
        XCTAssertEqual("34 Menschenjahre", birthdayMinus4Year.translateDogBirthdayToHumanYears.humanAge)
        XCTAssertEqual("0 Menschenjahre", birthdayMinus1Month.translateDogBirthdayToHumanYears.humanAge)
        XCTAssertEqual("0 Menschenjahre", birthdayMinus2Month.translateDogBirthdayToHumanYears.humanAge)
        XCTAssertEqual("0 Menschenjahre", birthdayPlus1Month.translateDogBirthdayToHumanYears.humanAge)
        XCTAssertEqual("29 Menschenjahre", birthdayAll.translateDogBirthdayToHumanYears.humanAge)
    }

    func helper(date: Date) -> String {
        let range = Calendar.current.range(of: .day, in: .month, for: date)!
        let numDays = range.count
        return numDays > 30 ? "5 Tage" : "6 Tage"
    }

    func testFormatted() throws {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yy"
        let date = dateFormatter.date(from: "02.09.1993")
        let dateFormatted = "2. September 1993"
        XCTAssertEqual(dateFormatted, date!.formatted)
    }
}
