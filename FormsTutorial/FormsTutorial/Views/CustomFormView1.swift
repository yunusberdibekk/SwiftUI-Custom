//
//  ContentView.swift
//  FormsTutorial
//
//  Created by Yunus Emre Berdibek on 22.12.2023.
//

import SwiftUI



struct CustomFormView1: View {
    @State var showingAlert: Bool = false
    @State var showingAlert2: Bool = false
    @State var name: String = ""
    @State var email: String = ""
    @State var street: String = ""
    @State var zipCode: String = ""

    @FocusState private var focusField: FormField?
    enum FormField {
        case name, email, street, zip
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name", text: $name)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 5))
                        .autocorrectionDisabled()
                        .submitLabel(.next)
                        .focused($focusField, equals: .name)
                        .onSubmit {
                            if name.isEmpty {
                                showingAlert2.toggle()
                            } else {
                                determineField()
                            }
                        }

                    TextField("Email", text: $email)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 5))
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled()
                        .submitLabel(.next)
                        .focused($focusField, equals: .email)
                        .onSubmit {
                            determineField()
                        }
                } header: {
                    Text("Basic Info")
                }

                Section {
                    TextField("Street", text: $street)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 5))
                        .autocorrectionDisabled()
                        .submitLabel(.next)
                        .focused($focusField, equals: .street)
                        .onSubmit {
                            determineField()
                        }

                    TextField("ZIP Code", text: $zipCode)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .clipShape(.rect(cornerRadius: 5))
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.none)
                        .autocorrectionDisabled()
                        .submitLabel(.done)
                        .focused($focusField, equals: .zip)
                        .onSubmit {
                            showingAlert.toggle()
                            print("Submit")
                        }
                } header: {
                    Text("Adress")
                }

                Button(action: {
                    // Do something
                    showingAlert.toggle()
                }, label: {
                    Text("Add User")
                })
                .alert("Form submitted", isPresented: $showingAlert, actions: {}, message: {
                    Text("Thanks \(name)\n We will be in contact soon @\(email)")
                })
                .alert("Required Field", isPresented: $showingAlert2, actions: {}, message: {
                    Text("You must enter a name!")
                })
            } //: Form
            .navigationTitle("User Info")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    Button(action: {
                        hideKeyboard()
                    }, label: {
                        Image(systemName: "keyboard.chevron.compact.down")
                    })
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
            }
            .onAppear {
                focusField = .name
            }
        } // :NavStack
    } //: Body

    func determineField() {
        switch focusField {
        case .name:
            focusField = .email
        case .email:
            focusField = .street
        case .street:
            focusField = .zip
        case .zip:
            focusField = nil
        default:
            focusField = nil
        }
    }
}

#Preview {
    CustomFormView1()
}
