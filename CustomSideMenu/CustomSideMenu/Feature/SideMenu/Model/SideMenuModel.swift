//
//  SideMenuModel.swift
//  CustomSideMenu
//
//  Created by Yunus Emre Berdibek on 14.05.2023.
//

import Foundation

enum SideMenuModel: Int, CaseIterable {
    case profile
    case notifications
    case settings
    case bookmarks
    case logout

    var tittle: String {
        switch self {
        case .profile: return "Profile"
        case .notifications: return "Notifications"
        case .settings: return "Settings"
        case .bookmarks: return "Bookmarks"
        case .logout: return "Log Out"
        }
    }

    var imageName: String {
        switch self {
        case .profile: return "person"
        case .notifications: return "bell"
        case .settings: return "gear"
        case .bookmarks: return "bookmark"
        case .logout: return "arrow.right"
        }
    }

}
