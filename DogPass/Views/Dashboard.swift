//
//  Dashboard.swift
//  DogPass
//
//  Created by Marius Preikschat on 09.03.23.
//

import SwiftUI

let deviceWidth = UIScreen.main.bounds.size.width

struct Dashboard: View {
    @ObservedObject var dogViewModel: DogViewModel

    @AppStorage("dog.selected") private var selectedDog = ""
    @State private var showSettingsSheet = false

    // TODO: make conditional when more cards are available and it when it will be editable
    @State var disableScroll = true

    var body: some View {
        if let dog = dogViewModel.dogs.first(where: { doggo in
            doggo.id.uuidString == selectedDog
        }) {
            NavigationView {
                ZStack {
                    VStack {
                        Text(dog.birthday.translateDogBirthdayToHumanYears.age)
                                .font(.caption)
                                .foregroundColor(Color.textSecondary)
                        Text(dog.birthday.translateDogBirthdayToHumanYears.humanAge)
                            .font(.caption)
                            .foregroundColor(Color.textSecondary)
                        Text(dog.birthday.calculateDaysUntilBirthday)
                            .font(.caption)
                            .foregroundColor(Color.textSecondary)
                        if let data = dog.image, let image = UIImage(data: data) {
                            Image(uiImage: image)
                                .resizable()
                                .scaledToFill()
                                .frame(maxWidth: deviceWidth, maxHeight: deviceWidth)
                                .clipShape(Circle())
                        } else {
                            ZStack {
                                Circle()
                                    .fill(Color(.systemGray))
                                    .frame(maxWidth: deviceWidth, maxHeight: deviceWidth)
                                Image(systemName: "photo")
                            }
                        }
                        ScrollView {
                            Grid(horizontalSpacing: 5, verticalSpacing: 5) {
                                GridRow {
                                    HeightCard(dogViewModel: dogViewModel, dog: dog)
                                    WeightCard(dogViewModel: dogViewModel, dog: dog)
                                }
                            }
                            GridRow {
                                VaccinationCard(dogViewModel: dogViewModel, dog: dog)
                            }
                        }
                        .scrollDisabled(disableScroll)
                        .padding()
                    }
                    .navigationTitle(dog.name)
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        Button {
                            showSettingsSheet = true
                        } label: {
                            Image(systemName: "gear")
                        }
                    }
                    .sheet(isPresented: $showSettingsSheet, content: {
                        Settings(dogViewModel: dogViewModel, showSettingsSheet: $showSettingsSheet)
                            .presentationDetents([.height(600), .large])
                            .presentationDragIndicator(.visible)
                    })
                }
            }
        } else {
            Text("no-dog-created")
        }
    }
}

func getCard(title: String, info: String) -> some View {
    return ZStack {
        RoundedRectangle(cornerRadius: 25, style: .continuous)
            .fill(Color.dpOrange)

        VStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.black)
            Spacer()
            Text(info)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding()
        .multilineTextAlignment(.center)
    }
}

struct Dashboard_Previews: PreviewProvider {
    static var previews: some View {
        let dVM = DogViewModel()
        Dashboard(dogViewModel: dVM)
    }
}
