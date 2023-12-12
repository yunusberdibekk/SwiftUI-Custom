//
//  HomeView.swift
//  CustomSideMenu
//
//  Created by Yunus Emre Berdibek on 14.05.2023.
//

import SwiftUI

struct HomeView: View {

    @Binding var showMenu: Bool
    @State var show = false

    var onTap: () -> Void

    var yearsAndPoints = [
        ("2008", "98"),
        ("2014", "384"),
        ("2015", "381"),
        ("2017", "363"),
        ("2018", "408"),
        ("2019", "413"),
        ("2020", "347")
    ]

    var body: some View {

        NavigationStack {
            VStack {
                HStack {
                    Button {
                        onTap()
                    } label: {
                        Image("hamilton")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 35, height: 35)
                            .clipShape(Circle())
                    }
                        .padding(.horizontal)
                        .padding(.vertical, 10)
                    Spacer()
                }
                Text("Sir Lewis Hamilton")
                    .font(.title2)

                List(yearsAndPoints, id: \.0) { year, points in
                    VStack(alignment: .leading) {
                        Text("Year: \(year)")
                            .font(.headline)
                        Text("Points: \(points)")
                            .foregroundColor(.gray)
                    }
                }
                    .listStyle(.plain)
            }
        }
    }
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(showMenu: .constant(false), onTap: { })
    }
}


