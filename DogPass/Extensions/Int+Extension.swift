//
//  Int+Extension.swift
//  DogPass
//
//  Created by Marius Preikschat on 19.03.23.
//

import Foundation

extension Int {
    var calculateHumanAge: Int {
        switch self {
        case 0:
            return 0
        case 1:
            return 15
        default:
            return 24 + (self - 2) * 5
        }
    }
}
