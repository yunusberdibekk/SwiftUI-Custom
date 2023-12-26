//
//  CreateContactViewModel.swift
//  FormsTutorial
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import Foundation

final class CreateContactViewModel: ObservableObject {
    @Published var newContact: NewContact = .empty

    var isValid: Bool {
        !newContact.general.prefix.isEmpty &&
            !newContact.general.firstName.isEmpty &&
            !newContact.general.lastName.isEmpty &&
            !newContact.contactInfo.phoneNumber.isEmpty
    }

    func clearAll() {
        newContact = .empty
    }
}
