//
//  Contacts.swift
//  DogPass
//
//  Created by Marius Preikschat on 22.03.23.
//

import SwiftUI

struct Contacts: View {
    @ObservedObject var contactViewModel: ContactViewModel

    @State private var showAddContactSheet = false
    @State private var searchText = ""

    var body: some View {
        NavigationView {
            ZStack {
                if contactViewModel.contacts.count > 0 {
                    List {
                        ForEach(searchResults, id: \.self) { contact in
                            NavigationLink(destination: DetailContact(contactViewModel: contactViewModel, contact: contact)) {
                                HStack {
                                    Text(contact.name)
                                }
                            }
                            .swipeActions(edge: .trailing) {
                                Button("delete") {
                                    contactViewModel.delete(contact)
                                }
                                .tint(.red)
                            }
                        }
                    }
                    .refreshable {
                        contactViewModel.fetchContacts()
                    }
                } else {
                    Text("no-contact-added")
                }
            }
            .toolbar {
                Button {
                    showAddContactSheet = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showAddContactSheet, content: {
                NewContact(contactViewModel: contactViewModel) { showAddContactSheet = false }
                    .presentationDetents([.height(500), .large])
                    .presentationDragIndicator(.visible)
            })
            .navigationTitle("your-contacts")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .searchable(text: $searchText)
    }

    var searchResults: [Contact] {
        let contacts = contactViewModel.contacts.sorted { $0.name.lowercased() < $1.name.lowercased() }

        if searchText.isEmpty {
            return contacts
        } else {
            return contacts.filter { $0.name.lowercased().contains(searchText.lowercased()) }
        }
    }
}

struct Contacts_Previews: PreviewProvider {
    static var previews: some View {
        let cVM = ContactViewModel()
        Contacts(contactViewModel: cVM)
    }
}
