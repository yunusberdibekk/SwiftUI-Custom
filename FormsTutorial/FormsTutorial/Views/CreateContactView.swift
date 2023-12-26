//
//  CreateContactView.swift
//  FormsTutorial
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import SwiftUI

struct CreateContactView: View {
    @Environment(\.presentationMode) private var presentationMode
    @Environment(\.dismiss) private var dismiss
    @StateObject var viewModel: CreateContactViewModel = .init()
    @FocusState private var focusField: NewContact.ContactFormField?

    let action: (_ contact: NewContact) -> Void

    var body: some View {
        NavigationStack {
            Form {
                general
                contact
                emergency
                clearAll
            }

            .navigationTitle("Add Contact")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button(action: {
                        hideKeyboard()
                    }, label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") {
                        action(viewModel.newContact)
                        handleDismissal()
                    }
                    .disabled(!viewModel.isValid)
                }

                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel) {
                        handleDismissal()
                    }
                }
            }
            .onAppear {
                focusField = .prefix
            }
        }
    }

    private func determineField() {
        switch focusField {
        case .prefix:
            focusField = .firstName
        case .firstName:
            focusField = .lastName
        case .lastName:
            focusField = .company
        case .company:
            focusField = .phoneNumber
        case .phoneNumber:
            focusField = .email
        case .email:
            focusField = .notes
        case .notes:
            focusField = nil
        default:
            focusField = nil
        }
    }
}

#Preview {
    CreateContactView(action: { _ in })
}

private extension CreateContactView {
    var general: some View {
        Section {
            TextField("Prefix", text: $viewModel.newContact.general.prefix)
                .textContentType(.namePrefix)
                .focused($focusField, equals: .prefix)
                .onSubmit {
                    determineField()
                }

            TextField("First Name", text: $viewModel.newContact.general.firstName)
                .textContentType(.name)
                .keyboardType(.namePhonePad)
                .focused($focusField, equals: .firstName)
                .onSubmit {
                    determineField()
                }

            TextField("Last Name", text: $viewModel.newContact.general.lastName)
                .textContentType(.familyName)
                .keyboardType(.namePhonePad)
                .focused($focusField, equals: .lastName)
                .onSubmit {
                    determineField()
                }

            Picker("Gender", selection: $viewModel.newContact.general.gender) {
                ForEach(NewContact.General.Gender.allCases) { item in
                    Text(item.rawValue.uppercased())
                }
            }
            .pickerStyle(.automatic)
            .onSubmit {
                determineField()
            }

            TextField("(Optional) Company", text: $viewModel.newContact.general.company)
                .textContentType(.organizationName)
                .focused($focusField, equals: .company)
                .onSubmit {
                    determineField()
                }
        } header: {
            Text("General")
        } footer: {
            Text("Please enter in any information about person")
        }
        .headerProminence(.increased)
    }

    var contact: some View {
        Section {
            TextField("Phone Number", text: $viewModel.newContact.contactInfo.phoneNumber)
                .textContentType(.telephoneNumber)
                .keyboardType(.phonePad)
                .focused($focusField, equals: .phoneNumber)
                .onSubmit {
                    determineField()
                }

            TextField("(Optinal) Email", text: $viewModel.newContact.contactInfo.email)
                .textContentType(.emailAddress)
                .keyboardType(.emailAddress)
                .focused($focusField, equals: .email)
                .onSubmit {
                    determineField()
                }
        }
    }

    var emergency: some View {
        Section {
            Toggle("Emergency Contact", isOn: $viewModel.newContact.emergency.isEmergency)

            TextEditor(text: $viewModel.newContact.emergency.notes)
                .onSubmit {
                    determineField()
                }
        } footer: {
            Text("Please enter in any information about this emergency contact that someone else should know")
                .focused($focusField, equals: .notes)
        }
    }

    var clearAll: some View {
        Button(role: .destructive) {
            withAnimation {
                viewModel.clearAll()
            }
        } label: {
            Text("Clear All")
        }
    }
}

private extension CreateContactView {
    func handleDismissal() {
        if #available(iOS 15, *) {
            dismiss()
        } else {
            presentationMode.wrappedValue.dismiss()
        }
    }
}
