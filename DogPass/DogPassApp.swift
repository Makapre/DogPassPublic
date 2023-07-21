//
//  DogPassApp.swift
//  DogPass
//
//  Created by Marius Preikschat on 09.03.23.
//

import SwiftUI
import CoreData

@main
struct DogPassApp: App {
    @ObservedObject var dogViewModel = DogViewModel()
    @ObservedObject var contactViewModel = ContactViewModel()

    var body: some Scene {
        WindowGroup {
            Start(dogViewModel: dogViewModel, contactViewModel: contactViewModel)
        }
    }
}
