//
//  UIImage+Extension.swift
//  DogPassTests
//
//  Created by Marius Preikschat on 24.05.23.
//

@testable import DogPass
import XCTest

final class UIImageExtension: XCTestCase {
    func testBase64() throws {
        XCTAssertNil(UIImage().base64)
    }
}
