//
//  View+Extension.swift
//  FormsTutorial
//
//  Created by Yunus Emre Berdibek on 23.12.2023.
//

import SwiftUI

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
