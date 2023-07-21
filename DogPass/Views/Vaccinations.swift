//
//  Vaccinations.swift
//  DogPass
//
//  Created by Marius Preikschat on 07.06.23.
//

import SwiftUI

struct Vaccinations: View {
    @ObservedObject var dogViewModel: DogViewModel

    @State private var showSheet = false
    @State private var showError = false
    @State private var name = ""
    @State private var start = Date.now
    @State private var end = Date.now.addingTimeInterval(86400)

    var dog: Dog

    var body: some View {
        ZStack {
            if let vaccinations: [Vaccination] = dog.vaccinations, vaccinations.count > 0 {
                List {
                    ForEach(vaccinations.sorted { $0.name.lowercased() < $1.name.lowercased() }, id: \.self) { vaccination in
                        NavigationLink(destination: DetailVaccination(vaccination: vaccination)) {
                            HStack {
                                Text(vaccination.name)
                                if vaccination.end.calucateDaysUntil < 28 {
                                    Spacer()
                                    Image(systemName: "exclamationmark.circle")
                                        .foregroundColor(vaccination.end.calucateDaysUntil < 1 ? .red : .orange)
                                }
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button("delete") {
                                dogViewModel.deleteVaccination(vaccination)
                            }
                            .tint(.red)
                        }
                    }
                }
            } else {
                Text("no-vaccinations")
            }
        }
        .toolbar {
            Image(systemName: "plus")
                .foregroundColor(.dpOrange)
                .onTapGesture {
                    showSheet = true
                }
        }
        .navigationTitle("vaccinations")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showSheet, content: {
            ZStack {
                VStack {
                    VStack {
                        Text("new-vaccination")
                        TextField(
                            "name",
                            text: $name,
                            onCommit: {
                                showError = name.count < 2
                            }
                        )
                        .disableAutocorrection(true)
                        .padding(.horizontal)
                        .textFieldStyle(.roundedBorder)

                        if showError {
                            Text("name-error")
                                .font(.caption)
                                .foregroundColor(.red)
                        }

                        DatePicker(selection: $start, in: ...Date.now, displayedComponents: .date) {
                            Text("vaccination-start")
                        }
                        .environment(\.locale, Locale(identifier: Locale.current.language.languageCode?.identifier ?? "us"))
                        .padding(.horizontal)

                        DatePicker(selection: $end, in: Date.now.addingTimeInterval(86400)..., displayedComponents: .date) {
                            Text("vaccination-end")
                        }
                        .environment(\.locale, Locale(identifier: Locale.current.language.languageCode?.identifier ?? "us"))
                        .padding()

                        Button("save") {
                            dogViewModel.addVaccination(name, start, end, dog)
                            name = ""
                            start = Date.now
                            end = Date.now.addingTimeInterval(86400)
                            showSheet = false
                        }
                        .buttonStyle(.bordered)
                        .disabled(name.count < 2)
                        .presentationDetents([.medium])
                        .presentationDragIndicator(.visible)
                    }
                }
            }
        })
        .onAppear {
            if dog.vaccinations == nil || dog.vaccinations?.isEmpty ?? true {
                showSheet = true
            }
        }
    }
}
