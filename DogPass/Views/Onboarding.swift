//
//  Onboarding.swift
//  DogPass
//
//  Created by Marius Preikschat on 10.03.23.
//

import SwiftUI

struct Onboarding: View {
    @ObservedObject var dogViewModel: DogViewModel

    @State private var startScreen = true

    var body: some View {
        if startScreen {
            VStack {
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 250, height: 250)
                    .padding()
                Text("onboarding-title")
                Button {
                    startScreen = false
                } label: {
                    Text("start")
                }
                .buttonStyle(.bordered)
                    .padding()
            }
            .transition(.opacity)
        } else {
            NewDog(dogViewModel: dogViewModel, label: Label("start-usage", systemImage: "arrow.right"))
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
        let dVM = DogViewModel()
        Onboarding(dogViewModel: dVM)
    }
}
