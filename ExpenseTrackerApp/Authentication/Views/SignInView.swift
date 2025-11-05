//
//  SignInView.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//

import SwiftUI

struct SignInView: View {
    @StateObject private var viewModel = SignInViewModel()
    
    @FocusState private var isFocused: Bool

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
                        .textContentType(.emailAddress)
                        .focused($isFocused)
                    
                    SecuredSignTextFieldView(title: "Password", inputText: "Enter your password", text: $viewModel.password)
                        .textContentType(.password)
                        .focused($isFocused)
                    
                    
                    Button {
                        viewModel.recoveryBottomSheet.toggle()
                        viewModel.isPasswordRecovery.toggle()
                        //  TODO: add password recovery logic
                    } label: {
                        Text("Forgot password?")
                            .font(.system(size: 12))
                            .foregroundStyle(.primaryTextClr)
                            .underline()
                    }
                    .padding(.top, -20)
                    .padding(.leading, 170)
                    .sheet(isPresented: $viewModel.recoveryBottomSheet) {
                        PasswordRecoveryEmailView()
                    }
                    
                    AuthProviderButtonView()
                    
                    Button {
                        Task {
                            try await viewModel.signIn()
                        }
                    } label: {
                        Text("Sign In")
                    }
                    .disabled(viewModel.isFormEmpty)
                    .opacity(viewModel.isFormEmpty ? 0.6 : 1)
                    .buttonStyle(GrowingButtonStyle())
                    .sheet(isPresented: $viewModel.isAuthenticated) {
                        OTPVerificationView(
                            email: $viewModel.email,
                            isPasswordRecovery: $viewModel.isPasswordRecovery
                        )
                    }
                    .alert(isPresented: $viewModel.isApiErrorMessagePresented) {
                        Alert(
                            title: Text("Authentication failed."),
                            message: Text(viewModel.errorMessage),
                            dismissButton: .cancel(Text("OK"))
                        )
                    }
                    .onTapGesture {
                        isFocused = false
                    }
                    
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
            .onTapGesture {
                isFocused = false
            }
        }
    }
}

#Preview {
    SignInView()
}
