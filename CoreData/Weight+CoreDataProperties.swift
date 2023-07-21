//
//  Weight+CoreDataProperties.swift
//  DogPass
//
//  Created by Marius Preikschat on 13.03.23.
//
//

import Foundation
import CoreData

extension Weight {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Weight> {
        return NSFetchRequest<Weight>(entityName: "Weight")
    }

    @NSManaged public var id: UUID
    @NSManaged public var timestamp: Date
    @NSManaged public var value: Double
    @NSManaged public var dog: Dog

}

extension Weight: Identifiable {

}
