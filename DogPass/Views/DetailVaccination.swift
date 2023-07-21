//
//  VaccinationDetail.swift
//  DogPass
//
//  Created by Marius Preikschat on 07.06.23.
//

import SwiftUI

struct DetailVaccination: View {

    var vaccination: Vaccination

    var body: some View {
        List {
            Section(header: Text("general")) {
                HStack {
                    Text("name")
                    Spacer()
                    Text(vaccination.name)
                }
            }

            Section(header: Text("dates")) {
                HStack {
                    Text("vaccination-start")
                    Spacer()
                    Text(vaccination.start.formatted)
                }
                HStack {
                    Text("vaccination-end")
                    Spacer()
                    Text(vaccination.end.formatted)
                }
            }

            Section(header: Text("validity")) {
                if vaccination.end.calucateDaysUntil < 0 {
                    HStack {
                        Text("invalid-since")
                        Image(systemName: "exclamationmark.circle")
                            .foregroundColor(.red)
                        Spacer()
                        Text("\(abs(vaccination.end.calucateDaysUntil))")
                    }
                } else {
                    HStack {
                        Text("valid")
                        if vaccination.end.calucateDaysUntil < 28 {
                            Image(systemName: "exclamationmark.circle")
                                .foregroundColor(.orange)
                        } else {
                            Image(systemName: "checkmark.circle")
                                .foregroundColor(.green)
                        }
                        Spacer()
                        Text("\(vaccination.end.calucateDaysUntil)")
                    }
                }
            }
        }
        .navigationTitle(vaccination.name)
    }
}
