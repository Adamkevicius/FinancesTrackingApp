//
//  SignInView.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//

import SwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 55)
                    .fill(.secondaryBackground)
                    .opacity(0.4)
                    .frame(height: 530)
                    .padding(.horizontal, 25)
                
                VStack {
                    Text("Welcome Back!")
                        .font(.system(size: 20))
                        .bold()
                        .padding(.bottom, 30)
                    
                    SignTextFieldView(title: "Email", inputText: "Enter your email", text: $viewModel.email)
                    
                    SecuredSignTextFieldView(title: "Password", inputText: "Enter your password", text: $viewModel.password)
                    
                    NavigationLink {
                        //  TODO: add password recovery logic
                    } label: {
                        Text("Forgot password?")
                            .font(.system(size: 12))
                            .foregroundStyle(.primaryTextClr)
                            .underline()
                    }
                    .padding(.top, -20)
                    .padding(.leading, 170)
                    
                    AuthProviderButtonView()
                    
                    Button {
                        
                    } label: {
                        Text("Sign In")
                    }
                    .disabled(viewModel.isFormValid)
                    .opacity(viewModel.isFormValid ? 0.6 : 1)
                    .buttonStyle(GrowingButtonStyle())
                    
                    HStack {
                        Text("New User?")
                            .font(.system(size: 12))
                        
                        NavigationLink {
                            SignUpView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Sign Up")
                                .font(.system(size: 14))
                                .underline()
                        }
                    }
                    
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBackground.gradient)
        }
    }
}

#Preview {
    SignInView()
}
