//
//  CitizienSignUP.swift
//  iOSSettingsView
//
//  Created by Yunus Emre Berdibek on 12.11.2023.
//

import SwiftUI

struct CitizienSignUp: View {
    @State var isShowingPassword: Bool = false

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    FormTextField(placeholder: "Full Name", labelBackground: .gray, icon: "person.fill", text: .constant(""))
                    FormTextField(placeholder: "Job", labelBackground: .gray, icon: "bag.fill", text: .constant(""))
                    FormTextField(placeholder: "Email", labelBackground: .gray, icon: "envelope.fill", text: .constant(""))
                    FormTextField(placeholder: "Phone", labelBackground: .gray, icon: "phone.fill", text: .constant(""))
                } header: {
                    Text("Personal informations")
                }

                Section {
                    FormTextField(placeholder: "Country", labelBackground: .gray, icon: "map.fill", text: .constant(""))
                    FormTextField(placeholder: "City", labelBackground: .gray, icon: "mappin", text: .constant(""))
                    FormTextField(placeholder: "District", labelBackground: .gray, icon: "mappin.and.ellipse", text: .constant(""))
                    FormTextField(placeholder: "Open adress", labelBackground: .gray, icon: "mappin.and.ellipse.circle", text: .constant(""))
                } header: {
                    Text("Adress")
                }

                Section {
                    FormTextField(placeholder: "Security question", labelBackground: .gray, icon: "questionmark.app.fill", text: .constant(""))

                    FormSecureField(placeholder: "Password", labelBackground: .gray, icon: "lock.fill", text: .constant("ALİVELİ"), isShowingPassword: $isShowingPassword)
                } header: {
                    Text("Security")
                }

                Section {
                    HStack {
                        Spacer()
                        Button("Sign Up") {}
                        Spacer()
                    }
                } footer: {
                    Text("By registering to this application you agree to the terms of use. ") +
                        Text("Click to learn the terms.")
                        .foregroundStyle(.blue)
                }
            }
            .navigationTitle("Sign Up")
            .toolbarTitleDisplayMode(.automatic)
        }
    }
}

struct FormTextField: View {
    let placeholder: String
    let labelBackground: Color
    let icon: String
    @Binding var text: String

    var body: some View {
        LabeledContent {} label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 32, height: 32)
                        .foregroundStyle(labelBackground)

                    Image(systemName: icon)
                        .foregroundStyle(.white)
                }

                TextField(placeholder, text: $text)
                    .font(.caption)
            }
        }
    }
}

struct FormSecureField: View {
    let placeholder: String
    let labelBackground: Color
    let icon: String
    @Binding var text: String
    @Binding var isShowingPassword: Bool

    var body: some View {
        LabeledContent {
            Button(action: {
                isShowingPassword.toggle()
            }, label: {
                Image(systemName: isShowingPassword ? "eye.slash.fill" : "eye.fill")
            })
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 32, height: 32)
                        .foregroundStyle(labelBackground)

                    Image(systemName: icon)
                        .foregroundStyle(.white)
                }

                if isShowingPassword {
                    TextField(placeholder, text: $text)
                        .font(.caption)
                } else {
                    SecureField(placeholder, text: $text)
                        .font(.caption)
                }
            }
        }
    }
}

#Preview {
    CitizienSignUp()
}
