//
//  DetailDog.swift
//  DogPass
//
//  Created by Marius Preikschat on 15.03.23.
//

import SwiftUI

struct DetailDog: View {
    @AppStorage("dog.selected") private var selectedDog = ""

    var dog: Dog

    var body: some View {
        List {
            Section(header: Text("general")) {
                HStack {
                    Text("name")
                    Spacer()
                    Text(dog.name)
                }
                HStack {
                    Text("birthday")
                    Spacer()
                    Text(dog.birthday.formatted)
                }
                HStack {
                    Text("gender")
                    Spacer()
                    Text(dog.sex ? "male" : "female")
                }
                HStack {
                    Text("castrated")
                    Spacer()
                    if dog.castration {
                        Text("yes")
                        Image(systemName: "checkmark.circle")
                            .foregroundColor(.green)
                    } else {
                        Text("no")
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(.red)
                    }
                }
            }

            Section(header: Text("stats")) {
                HStack {
                    Text("heights")
                    Spacer()
                    Text("\(dog.heights?.count ?? 0)")
                }
                HStack {
                    Text("weights")
                    Spacer()
                    Text("\(dog.weights?.count ?? 0)")
                }
                HStack {
                    Text("vaccinations")
                    Spacer()
                    Text("\(dog.vaccinations?.count ?? 0)")
                }
            }

            Section(header: Text("transponder")) {
                if let chip = dog.chip {
                    HStack {
                        Text("transponder-number")
                        Spacer()
                        Text(chip.number)
                    }
                    HStack {
                        Text("where")
                        Spacer()
                        Text(chip.place)
                    }
                } else {
                    Text("no-transponder")
                }
            }

            Section(header: Text("misc")) {
                HStack {
                    Text("race")
                    Spacer()
                    Text(dog.race ?? "-")
                }
                HStack {
                    Text("coat-color")
                    Spacer()
                    Text(dog.color ?? "-")
                }
            }
        }
        .navigationTitle(dog.name)
        .toolbar {
            if selectedDog != dog.id.uuidString {
                Button {
                    selectedDog = dog.id.uuidString
                } label: {
                    Text("choose")
                }
            }
        }
    }
}
