//
//  ContentView.swift
//  DogPass
//
//  Created by Marius Preikschat on 09.03.23.
//

import SwiftUI

struct Start: View {
    @ObservedObject var dogViewModel: DogViewModel
    @ObservedObject var contactViewModel: ContactViewModel

    var body: some View {
        if dogViewModel.dogs.isEmpty {
            Onboarding(dogViewModel: dogViewModel)
        } else {
            TabView {
                Dashboard(dogViewModel: dogViewModel)
                    .tabItem {
                        Label("dashboard", systemImage: "house")
                    }
                Dogs(dogViewModel: dogViewModel)
                    .tabItem {
                        Label("dogs", systemImage: "pawprint")
                    }
                    .badge(dogViewModel.dogs.count)
                Contacts(contactViewModel: contactViewModel)
                    .tabItem {
                        Label("contacts", systemImage: "person.crop.circle")
                    }
                    .badge(contactViewModel.contacts.count)
            }
            .accentColor(Color.dpOrange)
        }
    }
}

struct Start_Previews: PreviewProvider {
    static var previews: some View {
        let dVM = DogViewModel()
        let cVM = ContactViewModel()
        Start(dogViewModel: dVM, contactViewModel: cVM)
    }
}
