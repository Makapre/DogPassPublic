//
//  Address+CoreDataProperties.swift
//  DogPass
//
//  Created by Marius Preikschat on 22.03.23.
//
//

import Foundation
import CoreData

extension Address {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Address> {
        return NSFetchRequest<Address>(entityName: "Address")
    }

    @NSManaged public var id: UUID
    @NSManaged public var street: String
    @NSManaged public var zip: String
    @NSManaged public var housenumber: String
    @NSManaged public var country: String
    @NSManaged public var contact: Contact
    @NSManaged public var name: String
    @NSManaged public var city: String
    @NSManaged public var isValid: Bool

}

extension Address: Identifiable {

}
