//
//  NewAddress.swift
//  DogPass
//
//  Created by Marius Preikschat on 03.06.23.
//

import SwiftUI

struct NewAddress: View {
    @ObservedObject var contactViewModel: ContactViewModel

    var contact: Contact

    @State private var name = ""
    @State private var street = ""
    @State private var housenumber = ""
    @State private var zip = ""
    @State private var city = ""
    @State private var country = ""
    @State private var showNameError = false
    @State private var showZipError = false
    @State private var showCityError = false
    @State private var showCountryError = false
    @State private var showStreetError = false
    @State private var showHousenumberError = false

    var savingCallback: (() -> Void)?

    // swiftlint:disable opening_brace
    let regex = /(\d{5})/
    // swiftlint:enable opening_brace

    var match: Int { zip.matches(of: regex).count }

    var body: some View {
        return VStack {
            Text("add-new-address")
                .font(.title3)
                .padding(.bottom)
            nameField()
            streetHousenumberField()
                .padding(.top)
            zipCityField()
            countryField()
            Button {
                save()
            } label: {
                Text("save")
            }
            .buttonStyle(.bordered)
            .disabled(isSaveButtonDisabled())
        }
    }

    func isSaveButtonDisabled() -> Bool {
        let zipInvalid = match == 0
        return name.count < 2 || street.count < 2 || housenumber.empty || zipInvalid || city.count < 2 || country.count < 2
    }

    func nameField() -> some View {
        return VStack {
            Text("contact-name")
            TextField(
                "name",
                text: $name,
                onCommit: {
                    showNameError = name.count < 2
                }
            )
            .disableAutocorrection(true)
            .padding(.horizontal)
            .textFieldStyle(.roundedBorder)

            if showNameError {
                Text("name-error")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    func streetHousenumberField() -> some View {
        return VStack {
            Text("street-housenumber")
            GeometryReader { geometry in
                HStack {
                    TextField(
                        "street",
                        text: $street,
                        onCommit: {
                            showStreetError = street.count < 2
                        }
                    )
                    .disableAutocorrection(true)
                    .padding(.leading)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: geometry.size.width * 0.65)

                    TextField(
                        "housenumber",
                        text: $housenumber,
                        onCommit: {
                            showHousenumberError = housenumber.count < 1
                        }
                    )
                    .disableAutocorrection(true)
                    .padding(.trailing)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: geometry.size.width * 0.33)
                }
            }
            .frame(height: 50)

            if showStreetError {
                Text("street-error")
                    .font(.caption)
                    .foregroundColor(.red)
            }

            if showHousenumberError {
                Text("housenumber-error")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    func zipCityField() -> some View {
        return VStack {
            Text("zip-city")
            GeometryReader { geometry in
                HStack {
                    TextField(
                        "zip",
                        text: $zip.max(5),
                        onCommit: {
                            showZipError = match == 0
                        }
                    )
                    .keyboardType(.decimalPad)
                    .disableAutocorrection(true)
                    .padding(.leading)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: geometry.size.width * 0.33)

                    TextField(
                        "city",
                        text: $city,
                        onCommit: {
                            showCityError = city.count < 2
                        }
                    )
                    .disableAutocorrection(true)
                    .padding(.trailing)
                    .textFieldStyle(.roundedBorder)
                    .frame(width: geometry.size.width * 0.65)
                }
            }
            .frame(height: 50)

            if showZipError {
                Text("zip-error")
                    .font(.caption)
                    .foregroundColor(.red)
            }

            if showCityError {
                Text("city-error")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    func countryField() -> some View {
        return VStack {
            Text("country")
            TextField(
                "country",
                text: $country,
                onCommit: {
                    showCountryError = country.count < 2
                }
            )
            .disableAutocorrection(true)
            .padding(.horizontal)
            .textFieldStyle(.roundedBorder)

            if showCountryError {
                Text("country-error")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    func save() {
        let address = RawAddress(street: street, housenumber: housenumber, zip: zip, country: country, name: name, city: city)
        contactViewModel.addAddress(contact, address)

        guard let savingCallback = savingCallback else { return }
        savingCallback()
    }
}

struct NewAddress_Previews: PreviewProvider {
    static var previews: some View {
        let cVM = ContactViewModel()
        NewAddress(contactViewModel: cVM, contact: Contact())
    }
}
