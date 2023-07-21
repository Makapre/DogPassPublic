//
//  Height+CoreDataProperties.swift
//  DogPass
//
//  Created by Marius Preikschat on 13.03.23.
//
//

import Foundation
import CoreData

extension Height {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Height> {
        return NSFetchRequest<Height>(entityName: "Height")
    }

    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date
    @NSManaged public var value: Int16
    @NSManaged public var dog: Dog

}

extension Height: Identifiable {

}
