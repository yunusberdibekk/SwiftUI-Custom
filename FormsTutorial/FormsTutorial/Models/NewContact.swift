//
//  NewContact.swift
//  FormsTutorial
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import Foundation

struct NewContact: Identifiable {
    let id = UUID()
    var general: General
    var contactInfo: ContactInfo
    var emergency: Emergency
}

extension NewContact {
    enum ContactFormField {
        case prefix,
             firstName,
             lastName,
             company,
             phoneNumber,
             email,
             notes
    }
}

extension NewContact {
    struct General {
        var prefix: String
        var gender: Gender
        var firstName: String
        var lastName: String
        var company: String
    }
}

extension NewContact.General {
    enum Gender: String, Identifiable, CaseIterable {
        var id: Self { self }
        case male
        case female
        case na = "Prefer not to say"
    }
}

extension NewContact {
    struct ContactInfo {
        var phoneNumber: String
        var email: String
    }
}

extension NewContact {
    struct Emergency {
        var isEmergency: Bool
        var notes: String
    }
}

extension NewContact {
    static var empty: NewContact {
        let general = General(prefix: "",
                              gender: NewContact.General.Gender.allCases.first!,
                              firstName: "",
                              lastName: "",
                              company: "")
        let contactInfo = ContactInfo(phoneNumber: "",
                                      email: "")
        let emergency = Emergency(isEmergency: false,
                                  notes: "")
        return NewContact(general: general, contactInfo: contactInfo, emergency: emergency)
    }
}
