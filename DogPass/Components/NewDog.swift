//
//  NewDog.swift
//  DogPass
//
//  Created by Marius Preikschat on 15.03.23.
//

import SwiftUI

struct NewDog: View {
    @ObservedObject var dogViewModel: DogViewModel

    @State private var showError = false
    @State private var showingImagePicker = false
    @State private var showingCameraPicker = false
    @State private var image: UIImage?
    @State private var name = ""
    @State private var birthday = Date.now
    @State private var selectedGenderIndex: Int = 0
    @State private var selectedCastrationIndex: Int = 0

    var label: Label<Text, Image>?
    var savingCallback: (() -> Void)?

    let size = deviceWidth / 2

    var body: some View {
        return VStack {
            VStack {
                Spacer()
                Text("add-new-dog")
                    .font(.title3)
                if let image = image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: size, height: size)
                        .clipShape(Circle())
                        .padding(.top)
                } else {
                    ZStack {
                        Circle()
                            .fill(Color(.systemGray))
                            .frame(width: size, height: size)
                        Image(systemName: "photo")
                    }
                    .padding(.top)
                }
            }
            HStack {
                Button {
                    showingImagePicker = true
                } label: {
                    Label("choose-image", systemImage: "photo")
                        .font(.caption2)
                }
                .buttonStyle(.bordered)
                .padding(.trailing)

                Button {
                    showingCameraPicker = true
                } label: {
                    Label("take-photo", systemImage: "camera")
                        .font(.caption2)
                }
                .buttonStyle(.bordered)
                .padding(.leading)
            }
            .padding(.vertical)

            Text("")
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

            DatePicker(selection: $birthday, in: ...Date.now, displayedComponents: .date) {
                Text("dog-birthday")
            }
            .environment(\.locale, Locale(identifier: Locale.current.language.languageCode?.identifier ?? "us"))
            .padding()

            Picker("gender", selection: $selectedGenderIndex) {
                Text("male").tag(0)
                Text("female").tag(1)
            }
            .pickerStyle(.segmented)
            .padding()

            Picker("castration", selection: $selectedCastrationIndex) {
                Text("castration-no").tag(0)
                Text("castration-yes").tag(1)
            }
            .padding()
            .pickerStyle(.segmented)

            Spacer()

            Button {
                save()
            } label: {
                if let label = label {
                    label
                } else {
                    Text("save")
                }
            }
            .buttonStyle(.bordered)
            .disabled(name.count < 2)
            .padding(.bottom)
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $image)
        }
        .sheet(isPresented: $showingCameraPicker) {
            ImagePicker(sourceType: .camera, selectedImage: $image)
        }
    }

    func save() {
        if name.present {
            let sex = selectedGenderIndex == 0 // true => male
            let castration = selectedCastrationIndex == 1
            dogViewModel.addDog(name, birthday, sex, castration, image)

            guard let savingCallback = savingCallback else { return }
            savingCallback()
        } else {
            showError = true
        }
    }
}
