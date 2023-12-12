//
//  ContentView.swift
//  CustomDropdownMenu
//
//  Created by Yunus Emre Berdibek on 6.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var birthMonth: DropdownMenuOption? = nil
    var body: some View {
        VStack {
            DropdownMenu(selectedOption: self.$birthMonth, placeholder: "Select your birt month", options: DropdownMenuOption.testAllMonths)
            
            Text(birthMonth?.option ?? "")
            
            Spacer()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
