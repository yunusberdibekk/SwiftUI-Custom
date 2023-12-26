//
//  ContactsViewModel.swift
//  FormsTutorial
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import Foundation

final class ContactsViewModel: ObservableObject {
    @Published private(set) var contacts: [NewContact] = []

    func add(_ contact: NewContact) {
        contacts.append(contact)
    }
}
