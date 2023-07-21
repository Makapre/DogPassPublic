//
//  Address+Extension.swift
//  DogPass
//
//  Created by Marius Preikschat on 06.06.23.
//

import Foundation
import MapKit

extension Address {
    func isAddressValid() {
        let addressString = "\(self.housenumber) \(self.street), \(self.city), \(self.zip)"
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(addressString) { (placemarks, _) in
            guard let placemarks = placemarks, let loc = placemarks.first?.location else { return }
            dump(loc)
            self.isValid = true
        }
    }
}
