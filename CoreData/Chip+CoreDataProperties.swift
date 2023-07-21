//
//  Chip+CoreDataProperties.swift
//  DogPass
//
//  Created by Marius Preikschat on 13.03.23.
//
//

import Foundation
import CoreData

extension Chip {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Chip> {
        return NSFetchRequest<Chip>(entityName: "Chip")
    }

    @NSManaged public var id: UUID
    @NSManaged public var number: String
    @NSManaged public var place: String
    @NSManaged public var dog: Dog

}

extension Chip: Identifiable {

}
