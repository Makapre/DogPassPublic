//
//  String+Extension.swift
//  DogPass
//
//  Created by Marius Preikschat on 10.03.23.
//

import Foundation
import SwiftUI

extension String {
    var imageFromBase64: UIImage? {
        guard let imageData = Data(base64Encoded: self, options: .ignoreUnknownCharacters) else {
            return nil
        }
        return UIImage(data: imageData)
    }

    var empty: Bool {
        return self.count == 0
    }

    var present: Bool {
        return self.count > 0
    }
}
