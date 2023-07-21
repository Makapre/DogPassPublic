//
//  Int+Extension.swift
//  DogPassTests
//
//  Created by Marius Preikschat on 24.05.23.
//

@testable import DogPass
import XCTest

final class IntExtension: XCTestCase {
    func testCalculateHumanAge() throws {
        XCTAssertEqual(0, 0.calculateHumanAge)
        XCTAssertEqual(15, 1.calculateHumanAge)
        XCTAssertEqual(24, 2.calculateHumanAge)
        XCTAssertEqual(29, 3.calculateHumanAge)
        XCTAssertEqual(34, 4.calculateHumanAge)
    }
}
