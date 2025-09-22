//
//  SignTextFieldView 2.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//


//
//  SignTextFieldView.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 21/09/2025.
//

import SwiftUI

struct SignTextFieldView: View {
    var title: String
    var inputText: String
    @Binding var text: String
    var body: some View {
        Text(title)
            .foregroundStyle(.primaryTextClr)
            .bold()
            .font(.system(size: 14))
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 60)
        TextField(inputText, text: $text) {
            
        }
        .textFieldStyle(RoundedTextFieldStyle())
    }
}
