//
//  Dogs.swift
//  DogPass
//
//  Created by Marius Preikschat on 12.03.23.
//

import SwiftUI

struct Dogs: View {
    @ObservedObject var dogViewModel: DogViewModel

    @AppStorage("dog.selected") private var selectedDog = ""

    @State private var showDeleteDogConversation = false
    @State private var showAddDogSheet = false

    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ZStack {
                if dogViewModel.dogs.count > 0 {
                    List {
                        ForEach(searchResults, id: \.self) { dog in
                            NavigationLink(destination: DetailDog(dog: dog)) {
                                HStack {
                                    Text(dog.name)
                                    Spacer()
                                    if dog.id.uuidString == selectedDog {
                                        Image(systemName: dogViewModel.dogs.count == 1 ? "exclamationmark.circle" : "checkmark.circle")
                                            .foregroundColor(dogViewModel.dogs.count == 1 ? .red : .green)
                                    }
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button("delete") {
                                    if dogViewModel.dogs.count < 2 {
                                        showDeleteDogConversation = true
                                    } else {
                                        dogViewModel.delete(dog)
                                    }
                                }
                                .tint(.red)
                            }
                            .swipeActions(edge: .leading) {
                                if selectedDog != dog.id.uuidString {
                                    Button("choose") {
                                        selectedDog = dog.id.uuidString
                                    }
                                    .tint(.green)
                                }
                            }
                            .confirmationDialog("delete-dog", isPresented: $showDeleteDogConversation) {
                                Button("delete", role: .destructive, action: {
                                    dogViewModel.delete(dog)
                                })
                            } message: {
                                Text("dog-delete-confirm")
                            }
                        }
                    }
                }
            }
            .refreshable {
                dogViewModel.fetchDogs()
            }
            .navigationTitle("your-dogs")
            .toolbar {
                Button {
                    showAddDogSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddDogSheet, content: {
                NewDog(dogViewModel: dogViewModel) {
                    showAddDogSheet = false
                }
                .presentationDragIndicator(.visible)
            })
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .searchable(text: $searchText)
    }

    var searchResults: [Dog] {
        let dogs = dogViewModel.dogs.sorted { $0.name.lowercased() < $1.name.lowercased() }

        if searchText.isEmpty {
            return dogs
        } else {
            return dogs.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct Dogs_Previews: PreviewProvider {
    static var previews: some View {
        let dVM = DogViewModel()
        Dogs(dogViewModel: dVM)
    }
}
