//
//  CircularGrowingButtonStyle.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 21/09/2025.
//

import SwiftUI

struct CircularGrowingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .containerShape(Rectangle())
            .frame(width: 50, height: 50)
            .background(.white)
            .clipShape(.rect(cornerRadius: 25))
            .shadow(radius: 5)
            .padding(.horizontal, 10)
            .padding(.vertical, 25)
            .scaleEffect(configuration.isPressed ? 1.05 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
