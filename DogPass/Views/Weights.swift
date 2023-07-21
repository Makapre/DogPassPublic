//
//  Weight.swift
//  DogPass
//
//  Created by Marius Preikschat on 11.03.23.
//

import SwiftUI
import Charts

struct Weights: View {
    @ObservedObject var dogViewModel: DogViewModel

    var dog: Dog

    @State var showWeightSheet = false
    @State var dogWeightTmpValue: Double = 1.0
    @State var weightAlreadyTrackedToday = false
    @State private var showChart = false

    var body: some View {
        VStack {
            if let weights = dog.weights, weights.count > 0 {
                if showChart {
                    Chart {
                        ForEach(weights) { weight in
                            LineMark(
                                x: .value("when", weight.timestamp),
                                y: .value("how-heavy", weight.value)
                            )
                            .foregroundStyle(.blue)
                            .symbol(.circle)
                        }
                    }
                    .chartXAxisLabel("when", alignment: .center)
                    .chartYAxisLabel("how-heavy", position: .leading)
                    .padding(.horizontal)
                } else {
                    HStack {
                        Text("track-data-1")
                        Text("\(3 - weights.count)")
                            .bold()
                        Text("track-data-2")
                    }
                    Text("show-graph-down")
                }
            } else {
                Text("no-weight")
            }
        }
        .toolbar {
            Image(systemName: "plus")
                .foregroundColor(.dpOrange)
                .onTapGesture {
                    if let weights = dog.weights, weights.count > 0 {
                        let sortedWeights = weights.sorted(by: { heightA, heightB in
                            heightA.timestamp > heightB.timestamp
                        })
                        if let lastDate = sortedWeights.first?.timestamp {
                            weightAlreadyTrackedToday = Calendar.current.isDate(Date.now, inSameDayAs: lastDate)
                        }
                    }
                    showWeightSheet = true
                }
        }
        .navigationTitle("weight")
        .navigationBarTitleDisplayMode(.inline)
        .alert(isPresented: $weightAlreadyTrackedToday) {
            Alert(title: Text("already-weight"))
        }
        .sheet(isPresented: $showWeightSheet, content: {
            ZStack {
                Color.dpOrange.edgesIgnoringSafeArea(.all)
                VStack {
                    Text("enter-weight")
                        .foregroundColor(.text)
                    Stepper("\(dogWeightTmpValue.formatted()) kg", value: $dogWeightTmpValue, in: 0.5...120, step: 0.5)
                        .padding()
                        .fixedSize()
                        .foregroundColor(.text)
                    VStack {
                        Button("save") {
                            dogViewModel.addWeight(dogWeightTmpValue, dog)
                            showWeightSheet = false
                            guard let weightCount = dog.weights?.count else { return }
                            showChart = weightCount > 2
                        }
                        .buttonStyle(.bordered)
                        .foregroundColor(.text)
                        .presentationDetents([.height(180), .height(280)])
                        .presentationDragIndicator(.visible)
                    }
                }
            }
        })
        .onAppear {
            getLastWeight()
        }
    }

    func getLastWeight() {
        if let weights = dog.weights, weights.count > 0 {
            dogWeightTmpValue = weights.sorted(by: {weightA, weightB in
                weightA.timestamp < weightB.timestamp // from old to new
            }).last?.value ?? 1.0 // show latest height
            showChart = weights.count > 2
        }
    }
}
