//
//  HeightCard.swift
//  DogPass
//
//  Created by Marius Preikschat on 15.03.23.
//

import SwiftUI

struct ValidHeight {
    var isValid: Bool,
        height: Height?
}

struct HeightCard: View {
    @ObservedObject var dogViewModel: DogViewModel

    var dog: Dog

    var body: some View {
        return NavigationLink(destination: Heights(dogViewModel: dogViewModel, dog: dog)) {
            ZStack {
                RoundedRectangle(cornerRadius: 25, style: .continuous)
                    .fill(Color.dpBlue)

                VStack {
                    Text("height")
                    .font(.headline)
                    .foregroundColor(.text)
                    Spacer()
                    if hasValidHeight().isValid {
                        if let lastHeight = hasValidHeight().height {
                            Text(lastHeight.timestamp.formatted)
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Spacer()
                            Text("\(lastHeight.value.formatted()) cm")
                                .font(.subheadline)
                                .foregroundColor(.white)
                            Spacer()
                        }
                    } else {
                        Text("no-height")
                            .foregroundColor(.text)
                    }
                }
                .padding()
                .multilineTextAlignment(.center)
            }
        }
    }

    func hasValidHeight() -> ValidHeight {
        var validHeight = ValidHeight(isValid: false, height: nil)
        if let heights = dog.heights, heights.count > 0 {
            validHeight.isValid = true
            validHeight.height = heights.sorted(by: {heightA, heightB in
                heightA.timestamp < heightB.timestamp // from old to new
            }).last // show latest height
        }
        return validHeight
    }
}
