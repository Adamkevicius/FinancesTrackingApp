//
//  GrowingButtonStyles.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 21/09/2025.
//

import SwiftUI

struct GrowingButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .containerShape(Rectangle())
            .frame(width: 300, height: 50)
            .background(.primaryButtonClr)
            .clipShape(.rect(cornerRadius: 15))
            .foregroundStyle(.primaryTextClr)
            .hoverEffect(.lift)
            .scaleEffect(configuration.isPressed ? 1.02 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
