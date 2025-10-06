//
//  AuthProviderButtonView.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 21/09/2025.
//

import SwiftUI

struct AuthProviderButtonView: View {
    var body: some View {
        HStack {
            Button {
                //  TODO: ADD APPLE AUTH
            } label: {
                Image("apple-icon")
                    .resizable()
                    .frame(width: 35, height: 35)
            }
            .buttonStyle(CircularGrowingButtonStyle())
            Button {
                //  TODO: ADD GOOGLE AUTH
            } label: {
                Image("google-icon")
                    .resizable()
                    .frame(width: 35, height: 35)
            }
            .buttonStyle(CircularGrowingButtonStyle())
            Button {
                //  TODO: ADD FACEBOOK AUTH
            } label: {
                Image("facebook-icon")
                    .resizable()
                    .frame(width: 35, height: 35)
            }
            .buttonStyle(CircularGrowingButtonStyle())
        }
    }
}
