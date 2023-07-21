//
//  Heights.swift
//  DogPass
//
//  Created by Marius Preikschat on 15.03.23.
//

import SwiftUI
import Charts

struct Heights: View {
    @ObservedObject var dogViewModel: DogViewModel

    @State var showHeightSheet = false
    @State var dogHeightTmpValue: Int16 = 5
    @State var heightAlreadyTrackedToday = false
    @State private var showChart = false

    var dog: Dog

    var body: some View {
        VStack {
            if let heights = dog.heights, heights.count > 0 {
                if showChart {
                    Chart {
                        ForEach(heights) { height in
                            LineMark(
                                x: .value("when", height.timestamp),
                                y: .value("how-high", height.value)
                            )
                            .foregroundStyle(.red)
                            .symbol(.circle)
                        }
                    }
                    .chartXAxisLabel("when", alignment: .center)
                    .chartYAxisLabel("how-high", position: .leading)
                    .padding(.horizontal)
                } else {
                    HStack {
                        Text("track-data-1")
                        Text("\(3 - heights.count)")
                            .bold()
                        Text("track-data-2")
                    }
                    Text("show-graph-up")
                }
            } else {
                Text("no-height")
            }
        }
        .navigationTitle("height")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            Image(systemName: "plus")
                .foregroundColor(.dpOrange)
                .onTapGesture {
                    if let heights = dog.heights, heights.count > 0 {
                        let sortedHeights = heights.sorted(by: { heightA, heightB in
                            heightA.timestamp > heightB.timestamp
                        })
                        if let lastDate = sortedHeights.first?.timestamp {
                            heightAlreadyTrackedToday = Calendar.current.isDate(Date.now, inSameDayAs: lastDate)
                        }
                    }
                    showHeightSheet = true
                }
        }
        .alert(isPresented: $heightAlreadyTrackedToday) {
            Alert(title: Text("already-height"))
        }
        .sheet(isPresented: $showHeightSheet, content: {
            ZStack {
                Color.dpOrange.edgesIgnoringSafeArea(.all)
                VStack {
                    Text("enter-height")
                        .foregroundColor(.text)
                    Stepper("\(dogHeightTmpValue) cm", value: $dogHeightTmpValue, in: 5...110, step: 1)
                        .padding()
                        .fixedSize()
                        .foregroundColor(.text)
                    VStack {
                        Button("save", action: {
                            dogViewModel.addHeight(dogHeightTmpValue, dog)
                            showHeightSheet = false
                            guard let heightCount = dog.heights?.count else { return }
                            showChart = heightCount > 2
                        })
                        .buttonStyle(.bordered)
                        .foregroundColor(.text)
                        .presentationDetents([.height(180), .height(280)])
                        .presentationDragIndicator(.visible)
                    }
                }
            }
        })
        .onAppear {
            getLastHeight()
        }
    }

    func getLastHeight() {
        if let heights = dog.heights, heights.count > 0 {
            dogHeightTmpValue = heights.sorted(by: {heightA, heightB in
                heightA.timestamp < heightB.timestamp // from old to new
            }).last?.value ?? 5 // show latest height
            showChart = heights.count > 2
        }
    }
}
