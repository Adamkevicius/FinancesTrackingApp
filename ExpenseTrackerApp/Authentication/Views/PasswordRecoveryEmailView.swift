//
//  PasswordRecoveryEmailView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 30/09/2025.
//

import SwiftUI

struct PasswordRecoveryEmailView: View {
    @StateObject private var viewModel = PasswordRecoveryEmailViewModel()
    @Environment(\.dismiss) private var dismiss
    @FocusState private var isFocused: Bool
    
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 55)
                    .fill(.secondaryBackground)
                    .opacity(0.4)
                    .frame(height: 350)
                    .padding(.horizontal, 25)
                VStack {
                    Text("Password Recovery")
                        .font(.title)
                        .bold()
                        .padding(.bottom,)
                    Text("Enter your email to continue.")
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 25)
                        .padding(.bottom)
                    
                    SignTextFieldView(title: "Email", inputText: "Enter your email", text: $viewModel.email)
                        .focused($isFocused)
                    
                    Button("Enter") {
                        if viewModel.isCorrectEmail() {
                            viewModel.isPresented.toggle()
                            viewModel.isPasswordRecovery.toggle()
                        }
                        else if viewModel.email.isEmpty {
                            viewModel.emptyAlert.toggle()
                        }
                        else {
                            viewModel.wrongEmailAlert.toggle()
                        }
                    }
                    .buttonStyle(GrowingButtonStyle(
                        buttonColor: .primaryButtonClr,
                        textColor: .primaryTextClr,
                        width: 300,
                        height: 50
                    ))
                    .disabled(viewModel.isFormValid)
                    .opacity(viewModel.isFormValid ? 0.6 : 1)
                    .padding(.top)
                    .navigationDestination(
                        isPresented: $viewModel.isPresented,
                        destination: {
                            OTPVerificationView(
                                email: $viewModel.email,
                                isPasswordRecovery: $viewModel.isPasswordRecovery
                            )
                            .navigationBarBackButtonHidden(true)
                    })
                    .alert("Wrong email", isPresented: $viewModel.wrongEmailAlert) {
                        Button("OK", role: .cancel) { }
                    } message: {
                        Text("No account found with this email address. Please enter a valid email address.")
                            .multilineTextAlignment(.center)
                            .padding()
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Cancel")
                                .foregroundStyle(.black)
                                .bold()
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBackground)
            .onTapGesture {
                isFocused = false
            }
        }
    }
}
