//
//  String+Extension.swift
//  DogPassTests
//
//  Created by Marius Preikschat on 24.05.23.
//

@testable import DogPass
import XCTest

final class StringExtension: XCTestCase {

    func testImageFromBase64() throws {
        XCTAssertNil("".imageFromBase64)
        XCTAssertNil("abc".imageFromBase64)
    }

    func testEmpty() throws {
        XCTAssertTrue("".empty)
        XCTAssertFalse("a".empty)
    }

    func testPresent() throws {
        XCTAssertTrue("a".present)
        XCTAssertFalse("".present)
    }
}
