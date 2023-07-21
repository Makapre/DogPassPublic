//
//  DetailAddress.swift
//  DogPass
//
//  Created by Marius Preikschat on 22.03.23.
//

import SwiftUI
import MapKit

struct Location: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

struct DetailAddress: View {
    // default apple park coordinates
    @State private var region: MKCoordinateRegion = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275),
        span: MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5))

    @State private var locations: [Location] = []
    @State private var showMap: Bool = false

    var address: Address

    init(_ address: Address) {
        self.address = address
    }

    var body: some View {
        VStack {
            List {
                Section(header: Text("address")) {
                    Text("\(address.street) \(address.housenumber)")
                    Text("\(address.zip) \(address.city)")
                    Text(address.country)
                }
            }
            .scrollDisabled(true)
            .navigationTitle(address.name)

            if address.isValid && showMap {
                Button {
                    let url = URL(string: "maps://?saddr=&daddr=\(region.center.latitude),\(region.center.longitude)")
                    if UIApplication.shared.canOpenURL(url!) {
                        UIApplication.shared.open(url!, options: [:], completionHandler: nil)
                    }
                } label: {
                    Label("open-maps", systemImage: "map")
                }

                Map(coordinateRegion: $region, annotationItems: locations) {
                    MapMarker(coordinate: $0.coordinate)
                }
            } else if !address.isValid {
                VStack {
                    Spacer()
                    Label("invalid-address", systemImage: "exclamationmark.circle")
                        .foregroundColor(Color.red)
                    Spacer()
                }
            }
        }
        .onAppear(perform: getCoordinates)
    }

    func getCoordinates() {
        let addressString = "\(address.housenumber) \(address.street), \(address.city), \(address.zip)"
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(addressString) { (placemarks, _) in
            guard let placemarks = placemarks, let loc = placemarks.first?.location else { return }
            let coords = CLLocationCoordinate2D(latitude: loc.coordinate.latitude, longitude: loc.coordinate.longitude)
            region = MKCoordinateRegion(
                center: coords,
                span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            locations.append(Location(name: address.name, coordinate: coords))
            showMap = true
        }
    }
}
