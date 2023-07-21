//
//  Contact+CoreDataProperties.swift
//  DogPass
//
//  Created by Marius Preikschat on 22.03.23.
//
//

import Foundation
import CoreData

extension Contact {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Contact> {
        return NSFetchRequest<Contact>(entityName: "Contact")
    }

    @NSManaged public var id: UUID
    @NSManaged public var phone: String?
    @NSManaged public var mail: String?
    @NSManaged public var internet: String?
    @NSManaged public var name: String
    @NSManaged public var addresses: [Address]

}

// MARK: Generated accessors for addresses
extension Contact {

    @objc(addAddressesObject:)
    @NSManaged public func addToAddresses(_ value: Address)

    @objc(removeAddressesObject:)
    @NSManaged public func removeFromAddresses(_ value: Address)

}

extension Contact: Identifiable {

}
