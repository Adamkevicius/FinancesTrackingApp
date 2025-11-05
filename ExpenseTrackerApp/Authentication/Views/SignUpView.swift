//
//  ContentView.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 19/09/2025.
//

import SwiftUI

struct SignUpView: View {
    @StateObject private var viewModel = SignUpViewModel()
    
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 55)
                    .fill(.secondaryBackground)
                    .opacity(0.4)
                    .frame(height: 630)
                    .padding(.horizontal, 25)
                VStack {
                    Text("Sign Up To Continue")
                        .foregroundStyle(.primaryTextClr)
                        .font(.system(size: 20))
                        .bold()
                        .padding(.bottom, 40)
                    
                    Group {
                        SignTextFieldView(title: "Email", inputText: "Enter your email", text: $viewModel.email)
                            .textContentType(.emailAddress)
                            .focused($isFocused)
                        
                        SignTextFieldView(title: "Username", inputText: "Enter your username", text: $viewModel.username)
                            .textContentType(.username)
                            .focused($isFocused)
                        
                        SecuredSignTextFieldView(title: "Password", inputText: "Enter your password", text: $viewModel.password)
                            .textContentType(.password)
                            .focused($isFocused)
                    }
                    
                    AuthProviderButtonView()
                    
                    Button("Sign Up") {
                        Task {
                            await viewModel.signUp()
                        }
                    }
                    .disabled(viewModel.isFormValid)
                    .opacity(viewModel.isFormValid ? 0.6 : 1)
                    .buttonStyle(GrowingButtonStyle())
                    .sheet(isPresented: $viewModel.bottomSheet) {
                        OTPVerificationView(
                            email: $viewModel.email ,
                            isPasswordRecovery: $viewModel.isPasswordRecovery
                        )
                    }
                    .alert(isPresented: $viewModel.isApiErrorMessagePresented) {
                        Alert(
                            title: Text("Sign up failed."),
                            message: Text(viewModel.errorMessage),
                            dismissButton: .cancel(Text("OK"))
                        )
                    }
                    .onTapGesture {
                        isFocused = false
                    }
                    
                    HStack {
                        Text("Already have an account?")
                            .font(.system(size: 12))
                        NavigationLink {
                            SignInView()
                                .navigationBarBackButtonHidden(true)
                        } label: {
                            Text("Sign In")
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
    SignUpView()
}
