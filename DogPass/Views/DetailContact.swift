//
//  DetailContact.swift
//  DogPass
//
//  Created by Marius Preikschat on 22.03.23.
//

import SwiftUI

struct DetailContact: View {
    @ObservedObject var contactViewModel: ContactViewModel

    @State private var showAddAddressSheet = false

    var contact: Contact

    var body: some View {
        List {
            Section(header: Text("general")) {
                HStack {
                    Text("contact-name")
                    Spacer()
                    Text(contact.name)
                }
                if let val = contact.phone {
                    HStack {
                        Text("contact-phone")
                        Spacer()
                        if let url = URL(string: "tel:\(val)"), UIApplication.shared.canOpenURL(url) {
                            Button(val) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        } else {
                            Text(val)
                        }
                    }
                }
                if let val = contact.mail {
                    HStack {
                        Text("contact-mail")
                        Spacer()
                        if let url = URL(string: "mailto:\(val)"), UIApplication.shared.canOpenURL(url) {
                            Button(val) {
                                UIApplication.shared.open(url, options: [:], completionHandler: nil)
                            }
                        } else {
                            Text(val)
                        }
                    }
                }
                if let val = contact.internet {
                    HStack {
                        Text("contact-internet")
                        Spacer()
                        Link(val, destination: URL(string: val)!)
                    }
                }
            }

            Section(header: Text("addresses")) {
                if contact.addresses.count > 0 {
                    ForEach(contact.addresses, id: \.self) { address in
                        NavigationLink(destination: DetailAddress(address)) {
                            HStack {
                                Text(address.name)
                            }
                        }
                        .swipeActions(edge: .trailing) {
                            Button("delete") { contactViewModel.deleteAddress(contact, address)
                            }
                            .tint(.red)
                        }
                    }
                } else {
                    Text("no-address-added")
                }
            }
        }
        .toolbar {
            Button {
                showAddAddressSheet = true
            } label: {
                Image(systemName: "plus")
            }
        }
        .sheet(isPresented: $showAddAddressSheet, content: {
            NewAddress(contactViewModel: contactViewModel, contact: contact) { showAddAddressSheet = false }
                .presentationDetents([.height(500), .large])
                .presentationDragIndicator(.visible)
        })
        .navigationTitle(contact.name)
    }
}
