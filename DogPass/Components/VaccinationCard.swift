//
//  VaccinationCard.swift
//  DogPass
//
//  Created by Marius Preikschat on 07.06.23.
//

import SwiftUI

struct ValidVaccination {
    var isValid: Bool,
        vaccination: Vaccination?
}

struct VaccinationCard: View {
    @ObservedObject var dogViewModel: DogViewModel

    @State private var cardColor = Color.dpBlue

    var dog: Dog

    var body: some View {
        return NavigationLink(destination: Vaccinations(dogViewModel: dogViewModel, dog: dog)) {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(cardColor)

                VStack {
                    Text("vaccinations")
                        .font(.headline)
                        .foregroundColor(.text)
                    Spacer()
                    if hasValidVaccination().isValid {
                        if let vaccination = hasValidVaccination().vaccination {
                            HStack {
                                if vaccination.end.calucateDaysUntil == 0 {
                                    vaccinationName(vaccination.name)
                                    Text("vaccination-expires-today")
                                        .foregroundColor(.text)
                                } else {
                                    vaccinationName(vaccination.name)
                                    Text("vaccination-expires-in")
                                        .foregroundColor(.text)
                                    Text(vaccination.end.calucateDaysUntilInDays)
                                        .foregroundColor(.text)
                                        .italic()
                                }
                            }
                        } else {
                            Text("vaccination-expired")
                                .foregroundColor(.text)
                        }
                    } else {
                        Text("no-vaccinations")
                            .foregroundColor(.text)
                    }
                }
                .padding()
                .multilineTextAlignment(.center)
            }
        }
        .onAppear {
            if hasValidVaccination().isValid {
                if let vaccination = hasValidVaccination().vaccination {
                    cardColor = vaccination.end.calucateDaysUntil < 28 ? Color.dpOrange : Color.dpBlue
                } else {
                    cardColor = Color.red
                }
            } else {
                cardColor = Color.dpBlue
            }
        }
    }

    func vaccinationName(_ name: String) -> some View {
        return Text(name)
            .foregroundColor(.text)
            .bold()
    }

    func hasValidVaccination() -> ValidVaccination {
        var validVaccination = ValidVaccination(isValid: false, vaccination: nil)
        if let vaccinations = dog.vaccinations, vaccinations.count > 0 {
            validVaccination.isValid = true
            validVaccination.vaccination = vaccinations.filter({ $0.end.calucateDaysUntil > 0 }).sorted(by: { vaccinationA, vaccinationB in
                vaccinationA.end < vaccinationB.end // from old to new
            }).first // show earliest vaccination that ends
        }
        return validVaccination
    }
}
