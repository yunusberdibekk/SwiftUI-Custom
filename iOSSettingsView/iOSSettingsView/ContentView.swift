//
//  ContentView.swift
//  iOSSettingsView
//
//  Created by Yunus Emre Berdibek on 10.11.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List {
                Section {
                    HStack {
                        Spacer()
                        VStack(alignment: .center) {
                            Image(.profile)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(Circle())
                                .frame(width: 128, height: 128)

                            Text("Yunus Emre Berdibek")
                                .font(.system(.title, design: .rounded, weight: .bold))

                            Text("@yunusberdibekk")
                                .font(.callout)
                                .foregroundStyle(.gray)
                        }
                        Spacer()
                    }
                }

                Section {
                    NavigationLink(destination: {}) {
                        CustomLabeledContent(labelText: "Personal Information",
                                             labelTintColor: .gray,
                                             labelIcon: SFSembols.person_text.systemImage)
                    }

                    NavigationLink(destination: {}) {
                        CustomLabeledContent(labelText: "Payment & Shipping",
                                             labelTintColor: .red,
                                             labelIcon: "creditcard.fill",
                                             rowText: "Ibans")
                    }

                    NavigationLink(destination: {}) {
                        CustomLabeledContent(labelText: "Settings",
                                             labelTintColor: .blue,
                                             labelIcon: SFSembols.gear.systemImage)
                    }
                }

                Section {
                    HStack {
                        Spacer()
                        Text("Log Out")
                            .foregroundStyle(.red)
                        Spacer()
                    }
                }
            }
            .navigationTitle("Profile")
            .navigationBarTitleDisplayMode(.inline)
        }
    } // NavStack

    @ViewBuilder
    private func CustomLabel(title: String, rectangleForeground: Color = .gray, systemImage: String) -> some View {
        HStack(spacing: 12) {
            ZStack {
                RoundedRectangle(cornerRadius: 6)
                    .frame(width: 30, height: 30)
                    .foregroundStyle(rectangleForeground)

                Image(systemName: systemImage)
                    .renderingMode(.original)
                    .foregroundStyle(.white)
            }

            Text(title)
        }
    }
}

#Preview {
    ContentView()
}

enum SFSembols {
    case person_text
    case credit_card
    case lock_shield
    case icloud_fill
    case apps
    case info_circle
    case globe
    case swift
    case gear

    var systemImage: String {
        switch self {
        case .person_text:
            "person.text.rectangle.fill"
        case .credit_card:
            "creditcard.fill"
        case .lock_shield:
            "lock.shield.fill"
        case .icloud_fill:
            "icloud.fill"
        case .apps:
            "apps.iphone"
        case .info_circle:
            "info.circle"
        case .globe:
            "globe"
        case .swift:
            "swift"
        case .gear:
            "gear"
        }
    }

    var body: some View {
        Image(systemName: systemImage)
    }
}

struct CustomLabeledContent: View {
    let labelText: String
    let labelTintColor: Color
    let labelIcon: String
    var rowText: String?

    var body: some View {
        LabeledContent {
            if rowText != nil {
                Text(rowText!)
                    .foregroundStyle(.primary)
                    .fontWeight(.semibold)
            }
        } label: {
            HStack {
                ZStack {
                    RoundedRectangle(cornerRadius: 8)
                        .frame(width: 32, height: 32)
                        .foregroundStyle(labelTintColor)

                    Image(systemName: labelIcon)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                }

                Text(labelText)
            }
        }
    }
}
