//
//  SideMenuView.swift
//  CustomSideMenu
//
//  Created by Yunus Emre Berdibek on 14.05.2023.
//

import SwiftUI

struct SideMenuView: View {
    @Binding var showMenu: Bool

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 30) {
                VStack(alignment: .leading) {
                    Image("hamilton")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 65, height: 65)
                        .clipShape(Circle())

                    VStack(alignment: .leading, spacing: 4) {
                        Text("Lewis Hamilton")
                            .font(.headline)

                        Text("@LewisHamilton")
                            .font(.caption2)
                            .foregroundColor(.gray)
                    }

                }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.top, 65)

                ForEach(SideMenuModel.allCases, id: \.rawValue) { item in
                    if item == .profile {
                        NavigationLink {
                            ProfileView()
                        } label: {
                           SideMenuItem(model: item)
                        }
                    } else if item == .notifications {
                        NavigationLink {
                            NotificationsView()
                        } label: {
                            SideMenuItem(model: item)
                        }
                    } else if item == .settings {
                        NavigationLink {
                            SettingsView()
                        } label: {
                            SideMenuItem(model: item)
                        }
                    } else if item == .bookmarks {
                        NavigationLink {
                            BookmarksView()
                        } label: {
                            SideMenuItem(model: item)
                        }
                    } else {
                        NavigationLink {
                            LogOutView()
                        } label: {
                            SideMenuItem(model: item)
                        }
                    }
                }
                Spacer()
            }
        }
    }
}

struct SideMenuView_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuView(showMenu: .constant(false))
    }
}
