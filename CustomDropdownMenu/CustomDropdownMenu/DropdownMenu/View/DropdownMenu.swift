//
//  DropdownMenu.swift
//  CustomDropdownMenu
//
//  Created by Yunus Emre Berdibek on 6.05.2023.
//

import SwiftUI

struct DropdownMenu: View {
    @State var isOptionsPressed: Bool = false
    @Binding var selectedOption: DropdownMenuOption?
    
    let placeholder: String
    let options: [DropdownMenuOption]
    
    var body: some View {
        Button {
            withAnimation {
                self.isOptionsPressed.toggle()
            }
        } label: {
            HStack {
                Text(selectedOption == nil ? placeholder : selectedOption!.option)
                    .font(.callout)
                    .fontWeight(.medium)
                    .foregroundColor(selectedOption == nil ? .gray : .black)
                Spacer()
                
                Image(systemName: self.isOptionsPressed ? "chevron.up" : "chevron.down")
                    .fontWeight(.medium)
                    .foregroundColor(.black)
            }
        }
        .padding()
        .overlay {
            RoundedRectangle(cornerRadius: 5)
                .stroke(.gray, lineWidth: 2)
        }
        .overlay(alignment: .top) {
            VStack {
                if self.isOptionsPressed {
                    Spacer(minLength: 60)
                    DropdownMenuList(options: self.options) { option in
                        self.isOptionsPressed = false
                        self.selectedOption = option
                    }
                }
            }
        }
        .padding(.horizontal)
        .padding(.bottom, self.isOptionsPressed
                 ? CGFloat(self.options.count * 32) > 300
                 ? 300 + 30
                 : CGFloat(self.options.count * 32)
                 :0)
    }
}

struct DropDownMenu_Previews: PreviewProvider {
    static var previews: some View {
        DropdownMenu(selectedOption: .constant(nil), placeholder: "Select your birth month", options: DropdownMenuOption.testAllMonths)
    }
}
