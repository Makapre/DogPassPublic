//
//  ContactViewModel.swift
//  DogPass
//
//  Created by Marius Preikschat on 31.05.23.
//

import CoreData

class ContactViewModel: ObservableObject {
    private let viewContext = PersistenceController.shared.viewContext
    @Published var contacts: [Contact] = []

    init() {
        fetchContacts()
    }

    func fetchContacts() {
        let request = NSFetchRequest<Contact>(entityName: "Contact")

        do {
            contacts = try viewContext.fetch(request)
        } catch {
            print("DEBUG: Some error occured while fetching")
        }
    }

    func delete(_ contact: Contact) {
        viewContext.delete(contact)
        save()
        self.fetchContacts()
    }

    func deleteAddress(_ contact: Contact, _ address: Address) {
        contact.removeFromAddresses(address)
        viewContext.delete(address)
        save()
        self.fetchContacts()
    }

    func addContact(_ rawContact: RawContact) {
        let contact = Contact(context: viewContext)
        contact.id = UUID()
        contact.name = rawContact.name
        contact.phone = rawContact.phone
        contact.internet = rawContact.internet
        contact.mail = rawContact.mail

        save()
        self.fetchContacts()
    }

    func addAddress(_ contact: Contact, _ rawAddress: RawAddress) {
        let address = Address(context: viewContext)
        address.id = UUID()
        address.street = rawAddress.street
        address.housenumber = rawAddress.housenumber
        address.zip = rawAddress.zip
        address.city = rawAddress.city
        address.country = rawAddress.country
        address.name = rawAddress.name
        address.isAddressValid()

        address.contact = contact
        contact.addToAddresses(address)

        save()
        self.fetchContacts()
    }

    func save() {
        do {
            try viewContext.save()
        } catch {
            print("Error saving")
        }
    }
}
