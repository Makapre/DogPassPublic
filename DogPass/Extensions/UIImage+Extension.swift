//
//  UIImage+Extension.swift
//  DogPass
//
//  Created by Marius Preikschat on 10.03.23.
//

import Foundation
import SwiftUI

extension UIImage {
    var base64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}
