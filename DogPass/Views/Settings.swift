//
//  Settings.swift
//  DogPass
//
//  Created by Marius Preikschat on 09.03.23.
//

import SwiftUI

struct Settings: View {
    @ObservedObject var dogViewModel: DogViewModel

    @AppStorage("dog.selected") private var selectedDog = ""

    @State private var showEditImageConversation = false
    @State private var showingImagePicker = false
    @State private var showingCameraPicker = false
    @State private var image: UIImage?
    @State private var isSaving = false
    @State private var showCastrationDialog = false
    @State private var race = ""
    @State private var color = ""
    @State private var showTransponderDialog = false
    @State private var chipNumber = ""
    @State private var chipPlace = ""

    @Binding var showSettingsSheet: Bool

    var chipNumberLimit: Int = 15

    let size = deviceWidth / 2

    var body: some View {
        if let dog = dogViewModel.dogs.first(where: { doggo in
            doggo.id.uuidString == selectedDog
        }) {
            NavigationView {
                List {
                    Section(header: Text("image")) {
                        VStack {
                            if let unwrappedImage = image {
                                VStack {
                                    Image(uiImage: unwrappedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: size, height: size)
                                        .clipShape(Circle())

                                    Button("save", action: {
                                        isSaving = true
                                        Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                                            dog.image = unwrappedImage.pngData()
                                            dogViewModel.updateDog()

                                            image = nil
                                            isSaving = false
                                        }
                                    })
                                    .buttonStyle(.bordered)
                                }
                            }

                            HStack {
                                Text("take-choose-image")
                                Spacer()
                                Button {
                                    showEditImageConversation = true
                                } label: {
                                    Image(systemName: "photo")
                                }
                                .accentColor(.dpOrange)
                                .buttonStyle(.bordered)
                                .sheet(isPresented: $showingImagePicker) {
                                    ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
                                }
                                .sheet(isPresented: $showingCameraPicker) {
                                    ImagePicker(sourceType: .camera, selectedImage: $image)
                                }
                                .confirmationDialog("take-choose-image", isPresented: $showEditImageConversation) {
                                    Button {
                                        showingCameraPicker = true
                                    } label: {
                                        Label("take-photo", systemImage: "camera")
                                            .font(.caption2)
                                    }
                                    Button {
                                        showingImagePicker = true
                                    } label: {
                                        Label("choose-image", systemImage: "photo")
                                            .font(.caption2)
                                    }
                                } message: {
                                    Text("take-choose-image")
                                }
                            }
                        }
                    }

                    if !dog.castration {
                        Section("castration") {
                            HStack {
                                Text("is-castrated")
                                Spacer()
                                Button {
                                    dog.castration = true
                                    dogViewModel.updateDog()
                                } label: {
                                   Image(systemName: "checkmark.circle")
                                        .foregroundColor(.dpOrange)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                    }

                    if dog.chip != nil {
                        Text("already-transponder")
                    } else {
                        Section("transponder") {
                            HStack {
                                Text("has-transponder")
                                Spacer()
                                Button {
                                    showTransponderDialog = true
                                } label: {
                                    Image(systemName: "cpu")
                                        .foregroundColor(.dpOrange)
                                }
                                .buttonStyle(.bordered)
                            }
                        }
                        .sheet(isPresented: $showTransponderDialog) {
                            VStack {
                                Text("transponder-number")
                                TextField(
                                    "number",
                                    text: $chipNumber
                                )
                                .disableAutocorrection(true)
                                .textFieldStyle(.roundedBorder)

                                Text("where-transponder")
                                    .padding(.top)
                                TextField(
                                    "place",
                                    text: $chipPlace
                                )
                                .disableAutocorrection(true)
                                .textFieldStyle(.roundedBorder)

                                Button("save", action: {
                                    isSaving = true
                                    Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                                        dogViewModel.addChip(chipNumber, chipPlace, dog)
                                        chipNumber = ""
                                        chipPlace = ""
                                        isSaving = false
                                        showTransponderDialog = false
                                    }
                                })
                                .padding(.top)
                                .buttonStyle(.bordered)
                                .disabled(chipPlace.empty && chipNumber.empty)
                            }
                            .padding()
                        }
                    }

                    Section("misc") {
                        VStack(alignment: .leading) {
                            Text("dog-race")
                            if let dogRace = dog.race {
                                HStack {
                                    Text("dog-race-current")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(dogRace)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            TextField(
                                "race",
                                text: $race
                            )
                            .disableAutocorrection(true)
                            .textFieldStyle(.roundedBorder)

                            Text("dog-color")
                            if let dogColor = dog.color {
                                HStack {
                                    Text("dog-color-current")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                    Text(dogColor)
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                            TextField(
                                "coat-color",
                                text: $color
                            )
                            .disableAutocorrection(true)
                            .textFieldStyle(.roundedBorder)

                            Button {
                                isSaving = true
                                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { _ in
                                    if race.present {
                                        dog.race = race
                                        race = ""
                                    }

                                    if color.present {
                                        dog.color  = color
                                        color = ""
                                    }
                                    dogViewModel.updateDog()
                                    isSaving = false
                                }
                            } label: {
                                Text("save")
                            }
                            .disabled(!(race.present || color.present))
                            .buttonStyle(.bordered)
                        }
                    }
                }
                .navigationTitle("preferences")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    Button {
                        showSettingsSheet = false
                    } label: {
                        Text("complete")
                    }
                }

                if isSaving {
                    ZStack {
                        Color.gray.opacity(0.5).ignoresSafeArea()
                        VStack {
                            ProgressView()
                            Text("save")
                        }
                    }
                }
            }
        } else {
            Text("no-dog-created")
        }
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        @State var showSettingsSheet = false

        let dVM = DogViewModel()

        Settings(dogViewModel: dVM, showSettingsSheet: $showSettingsSheet)
    }
}
