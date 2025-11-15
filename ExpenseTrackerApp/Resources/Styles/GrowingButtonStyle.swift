//
//  GrowingButtonStyles.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 21/09/2025.
//

import SwiftUI

struct GrowingButtonStyle: ButtonStyle {
    let buttonColor: Color
    let textColor: Color
    let width: CGFloat
    let height: CGFloat
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .containerShape(Rectangle())
            .frame(width: width, height: height)
            .background(buttonColor)
            .clipShape(.rect(cornerRadius: 10))
            .foregroundStyle(textColor)
            .hoverEffect(.lift)
            .scaleEffect(configuration.isPressed ? 1.15 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}
