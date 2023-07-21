//
//  WeightCard.swift
//  DogPass
//
//  Created by Marius Preikschat on 09.03.23.
//

import SwiftUI

struct ValidWeight {
    var isValid: Bool,
    weight: Weight?
}

struct WeightCard: View {
    @ObservedObject var dogViewModel: DogViewModel
    @State private var lastWeight: Weight?

    var dog: Dog

    var body: some View {
        return NavigationLink(destination: Weights(dogViewModel: dogViewModel, dog: dog)) {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.dpBlue)

                VStack {
                    Text("weight")
                        .font(.headline)
                        .foregroundColor(.text)
                    Spacer()
                    if hasValidWeight().isValid {
                        if let lastWeight = hasValidWeight().weight {
                            Text(lastWeight.timestamp.formatted)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(lastWeight.value.formatted()) kg")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    } else {
                        Text("no-weight")
                            .foregroundColor(.text)
                    }
                }
                .padding()
                .multilineTextAlignment(.center)
            }
        }
    }

    func hasValidWeight() -> ValidWeight {
        var validWeight = ValidWeight(isValid: false, weight: nil)
        if let weights = dog.weights, weights.count > 0 {
            validWeight.isValid = true
            validWeight.weight = weights.sorted(by: {heightA, heightB in
                heightA.timestamp < heightB.timestamp // from old to new
            }).last // show latest weight
        }
        return validWeight
    }
}
