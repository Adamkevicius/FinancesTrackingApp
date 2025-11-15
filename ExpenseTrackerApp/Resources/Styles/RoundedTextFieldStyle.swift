//
//  RoundedTextFieldStyle.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 21/09/2025.
//

import SwiftUI

struct RoundedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.vertical, 25)
            .padding(.horizontal, 25)
            .contentShape(Rectangle())
            .frame(height: 50)
            .background(.textFieldBackground)
            .brightness(0.4)
            .clipShape(.rect(cornerRadius: 15))
            .padding(.horizontal, 50)
            .padding(.bottom)
    }
}
