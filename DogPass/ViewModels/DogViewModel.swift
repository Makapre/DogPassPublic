//
//  StartViewModel.swift
//  DogPass
//
//  Created by Marius Preikschat on 31.05.23.
//

import CoreData
import SwiftUI

class DogViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var dogs: [Dog] = []
    @AppStorage("dog.selected") private var selectedDog = ""

    init() {
        fetchDogs()
    }

    func fetchDogs() {
        let request = NSFetchRequest<Dog>(entityName: "Dog")

        do {
            dogs = try viewContext.fetch(request)
        } catch {
            print("DEBUG: Some error occured while fetching")
        }
    }

    func addDog(_ name: String, _ birthday: Date, _ sex: Bool, _ castration: Bool, _ image: UIImage?) {
        let dog = Dog(context: viewContext)
        dog.id = UUID()
        dog.name = name

        if let image = image {
            dog.image = image.pngData()
        }
        dog.birthday = birthday
        dog.sex = sex
        dog.castration = castration

        save()
        self.fetchDogs()
        selectedDog = dog.id.uuidString
    }

    func addWeight(_ value: Double, _ dog: Dog) {
        let weight = Weight(context: viewContext)
        weight.id = UUID()
        weight.value = value
        weight.timestamp = Date.now
        weight.dog = dog

        dog.addToWeights(weight)

        save()
        self.fetchDogs()
    }

    func addHeight(_ value: Int16, _ dog: Dog) {
        let height = Height(context: viewContext)
        height.id = UUID()
        height.value = value
        height.timestamp = Date.now
        height.dog = dog

        dog.addToHeights(height)

        save()
        self.fetchDogs()
    }

    func addChip(_ chipNumber: String, _ chipPlace: String, _ dog: Dog) {
        let chip = Chip(context: viewContext)
        chip.id = UUID()

        if chipNumber.present {
            chip.number = chipNumber
        }

        if chipPlace.present {
            chip.place  = chipPlace
        }
        chip.dog = dog
        dog.chip = chip

        save()
        self.fetchDogs()
    }

    func addVaccination(_ name: String, _ start: Date, _ end: Date, _ dog: Dog) {
        let vaccination = Vaccination(context: viewContext)
        vaccination.id = UUID()
        vaccination.name = name
        vaccination.start = start
        vaccination.end = end
        vaccination.dog = dog

        dog.addToVaccinations(vaccination)

        save()
        self.fetchDogs()
    }

    func deleteVaccination(_ vaccination: Vaccination) {
        viewContext.delete(vaccination)
        save()
        self.fetchDogs()
    }

    func delete(_ dog: Dog) {
        let filteredDogs = dogs.filter { $0.id.uuidString != selectedDog }
        if filteredDogs.count > 0 {
            if selectedDog == dog.id.uuidString {
                let sortedDogs = filteredDogs.sorted { $0.name.lowercased() < $1.name.lowercased() }
                if let newSelectedDog = sortedDogs.first {
                    selectedDog = newSelectedDog.id.uuidString
                }
            }
        }

        viewContext.delete(dog)
        save()
        self.fetchDogs()
    }

    func updateDog() {
        save()
        self.fetchDogs()
    }

    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving")
        }
    }
}
