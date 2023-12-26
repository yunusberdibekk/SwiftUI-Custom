//
//  ContactInfoView.swift
//  FormsTutorial
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import SwiftUI

struct ContactInfoView: View {
    @State var showEmergencyInfo: Bool = false
    let contact: NewContact

    var body: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            Text("\(contact.general.prefix). \(contact.general.firstName) \(contact.general.lastName)")
                .font(.title3)
                .bold()
            Text("**Gender**: \(contact.general.gender.rawValue.uppercased())")
            Text("**Company**: \(contact.general.company)")

            Divider()

            Text("**Phone**: \(contact.contactInfo.phoneNumber)")
            Text("**Email**: \(contact.contactInfo.email)")

            if contact.emergency.isEmergency {
                Divider()

                HStack {
                    Group {
                        Image(systemName: "exclamationmark.octagon")
                            .symbolVariant(.fill)
                            .font(.title)
                        Text("Emergency Contact")
                            .font(.title2)
                            .bold()
                    }
                    .foregroundStyle(.red)

                    Spacer()

                    Button(action: {
                        withAnimation {
                            showEmergencyInfo.toggle()
                        }
                    }, label: {
                        Image(systemName: showEmergencyInfo ? "chevron.up" : "chevron.down")
                            .symbolVariant(.circle.fill)
                    })
                    .font(.title)
                    .foregroundStyle(.gray.opacity(0.5))
                }

                if showEmergencyInfo {
                    Text(contact.emergency.notes)
                }
            }

        })
        .padding()
        .background(.gray.opacity(0.1), in: RoundedRectangle(cornerRadius: 12, style: .continuous))
    }
}

#Preview {
    ContactInfoView(contact: NewContact.empty)
        .padding()
        .background(.white)
}
