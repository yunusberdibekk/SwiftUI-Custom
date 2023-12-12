//
//  DropdownMenuListRow.swift
//  CustomDropdownMenu
//
//  Created by Yunus Emre Berdibek on 6.05.2023.
//

import SwiftUI

struct DropdownMenuListRow: View {
    let option: DropdownMenuOption
    
    let onSelectedAction: (_ option: DropdownMenuOption) -> Void
    
    var body: some View {
        Button {
            self.onSelectedAction(option)
        } label: {
            Text(option.option)
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.callout)
        }
        .foregroundColor(.black)
        .padding(.vertical)
        .padding(.horizontal)
        
    }
}

struct DropdownMenuListRow_Previews: PreviewProvider {
    static var previews: some View {
        DropdownMenuListRow(option: .testSingleMonth, onSelectedAction: { _ in })
    }
}
