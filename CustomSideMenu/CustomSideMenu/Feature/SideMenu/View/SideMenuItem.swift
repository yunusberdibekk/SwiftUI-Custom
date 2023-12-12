//
//  SideMenuItem.swift
//  CustomSideMenu
//
//  Created by Yunus Emre Berdibek on 14.05.2023.
//

import SwiftUI

struct SideMenuItem: View {
    let model: SideMenuModel

    var body: some View {
        HStack(spacing: 16) {
            Image(systemName: model.imageName)
                .font(.headline)
                .foregroundColor(.gray)

            Text(model.tittle)
                .foregroundColor(.black)
                .font(.subheadline)
            Spacer()
        }
            .frame(height: 40)
            .padding(.horizontal)
    }
}

struct SideMenuItem_Previews: PreviewProvider {
    static var previews: some View {
        SideMenuItem(model: .profile)
    }
}
