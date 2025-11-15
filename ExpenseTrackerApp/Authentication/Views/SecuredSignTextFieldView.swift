//
//  SecuredSignTextFieldView.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//

import SwiftUI

struct SecuredSignTextFieldView: View {
    var title: String
    var inputText: String
    @Binding var text: String
    @State private var isSecured = true
    var body: some View {
        ZStack {
            VStack {
                Group {
                    Text(title)
                        .foregroundStyle(.primaryTextClr)
                        .bold()
                        .font(.system(size: 14))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal, 60)
                    if isSecured {
                        SecureField(inputText, text: $text)
                            .textFieldStyle(RoundedTextFieldStyle())
                            .textInputAutocapitalization(.never)
                    }
                    else {
                        TextField(inputText, text: $text)
                            .textFieldStyle(RoundedTextFieldStyle())
                            .textInputAutocapitalization(.never)
                    }
                }
            }
            
            Button {
                isSecured.toggle()
            } label: {
                Image(systemName: self.isSecured ? "eye.slash" : "eye")
                    .tint(.gray)
            }
            .padding(.bottom, -10)
            .padding(.leading, 250)
        }
    }
}

