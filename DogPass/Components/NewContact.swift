//
//  NewContact.swift
//  DogPass
//
//  Created by Marius Preikschat on 03.06.23.
//

import SwiftUI

struct NewContact: View {
    @ObservedObject var contactViewModel: ContactViewModel

    @State private var name = ""
    @State private var phone = ""
    @State private var mail = ""
    @State private var internet = ""
    @State private var showNameError = false
    @State private var showMailError = false
    @State private var showPhoneError = false
    @State private var showInternetError = false

    var savingCallback: () -> Void

    // swiftlint:disable opening_brace
    let phoneRegex = /(^[\+]?[(]?[0-9]{3}[)]?[-\s\.]?[0-9]{3}[-\s\.]?[0-9]{4,6}$)/
    let mailRegex = /([^@ \t\r\n]+@[^@ \t\r\n]+\.[^@ \t\r\n]+)/
    let internetRegex = /(https?:\/\/)(www\.)?[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()!@:%_\+.~#?&=]*)/
    // swiftlint:enable opening_brace

    var noMatchPhone: Bool { phone.matches(of: phoneRegex).count == 0  && phone.present}
    var noMatchMail: Bool { mail.matches(of: mailRegex).count == 0  && mail.present}
    var noMatchInternet: Bool { internet.matches(of: internetRegex).count == 0  && internet.present}

    fileprivate func contactName() -> some View {
        return VStack {
            Text("contact-name")
            TextField(
                "contact-name",
                text: $name,
                onEditingChanged: { changed in
                    if !changed {
                        showNameError = name.count < 2
                    }
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

    fileprivate func contactMail() -> some View {
        return VStack {
            Text("contact-mail")
            TextField(
                "contact-mail",
                text: $mail,
                onEditingChanged: { changed in
                    if !changed {
                        showMailError = noMatchMail
                    }
                }
            )
            .keyboardType(.emailAddress)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.horizontal)
            .textFieldStyle(.roundedBorder)

            if showMailError {
                Text("mail-error")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    fileprivate func contactPhone() -> some View {
        return VStack {
            Text("contact-phone")
            TextField(
                "contact-phone",
                text: $phone,
                onEditingChanged: { changed in
                    if !changed {
                        showPhoneError = noMatchPhone
                    }
                }
            )
            .keyboardType(.phonePad)
            .disableAutocorrection(true)
            .padding(.horizontal)
            .textFieldStyle(.roundedBorder)

            if showPhoneError {
                Text("phone-error")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    fileprivate func contactInternet() -> some View {
        return VStack {
            Text("contact-internet")
            TextField(
                "contact-internet",
                text: $internet,
                onEditingChanged: { changed in
                    if !changed {
                        showInternetError = noMatchInternet
                    }
                }
            )
            .keyboardType(.URL)
            .autocapitalization(.none)
            .disableAutocorrection(true)
            .padding(.horizontal)
            .textFieldStyle(.roundedBorder)

            if showInternetError {
                Text("internet-error")
                    .font(.caption)
                    .foregroundColor(.red)
            }
        }
    }

    var body: some View {
        return VStack {
            Text("add-new-contact")
                .font(.title3)
                .padding()

            contactName()
            contactMail()
            contactPhone()
            contactInternet()

            Button {
                save()
            } label: {
                Text("save")
            }
            .buttonStyle(.bordered)
            .disabled(buttonDisabled())
        }
    }

    func buttonDisabled() -> Bool {
        return name.count < 2 || noMatchMail || noMatchPhone || noMatchInternet
    }

    func save() {
        var contact = RawContact(name: name)
        contact.phone = phone.present ? phone : nil
        contact.mail = mail.present ? mail : nil
        contact.internet = internet.present ? internet : nil

        contactViewModel.addContact(contact)
        savingCallback()
    }
}
