//
//  Dog+CoreDataProperties.swift
//  DogPass
//
//  Created by Marius Preikschat on 13.03.23.
//
//

import Foundation
import CoreData

extension Dog {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Dog> {
        return NSFetchRequest<Dog>(entityName: "Dog")
    }

    @NSManaged public var birthday: Date
    @NSManaged public var castration: Bool
    @NSManaged public var color: String?
    @NSManaged public var id: UUID
    @NSManaged public var image: Data?
    @NSManaged public var name: String
    @NSManaged public var race: String?
    @NSManaged public var sex: Bool
    @NSManaged public var chip: Chip?
    @NSManaged public var heights: [Height]?
    @NSManaged public var vaccinations: [Vaccination]?
    @NSManaged public var weights: [Weight]?

}

// MARK: Generated accessors for heights
extension Dog {

    @objc(addHeightsObject:)
    @NSManaged public func addToHeights(_ value: Height)

    @objc(removeHeightsObject:)
    @NSManaged public func removeFromHeights(_ value: Height)

}

// MARK: Generated accessors for vaccinations
extension Dog {

    @objc(addVaccinationsObject:)
    @NSManaged public func addToVaccinations(_ value: Vaccination)

    @objc(removeVaccinationsObject:)
    @NSManaged public func removeFromVaccinations(_ value: Vaccination)

}

// MARK: Generated accessors for weights
extension Dog {

    @objc(addWeightsObject:)
    @NSManaged public func addToWeights(_ value: Weight)

    @objc(removeWeightsObject:)
    @NSManaged public func removeFromWeights(_ value: Weight)

}

extension Dog: Identifiable {

}
