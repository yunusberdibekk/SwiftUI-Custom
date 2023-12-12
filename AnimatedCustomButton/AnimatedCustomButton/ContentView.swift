//
//  ContentView.swift
//  AnimatedCustomButton
//
//  Created by Yunus Emre Berdibek on 27.09.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        CustomButton(buttonTint: .blue) {
            HStack(spacing: 10) {
                Text("Login")
                Image(systemName: "chevron.right")
            }
                .fontWeight(.bold)
                .foregroundStyle(.white)

        } action: {
            try? await Task.sleep(for: .seconds(2))
            return .failed("Error")
        }
            .buttonStyle(.opacityLess)
            .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}
