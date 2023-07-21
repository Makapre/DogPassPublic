//
//  Vaccination+CoreDataProperties.swift
//  DogPass
//
//  Created by Marius Preikschat on 13.03.23.
//
//

import Foundation
import CoreData

extension Vaccination {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Vaccination> {
        return NSFetchRequest<Vaccination>(entityName: "Vaccination")
    }

    @NSManaged public var end: Date
    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var start: Date
    @NSManaged public var dog: Dog

}

extension Vaccination: Identifiable {

}
