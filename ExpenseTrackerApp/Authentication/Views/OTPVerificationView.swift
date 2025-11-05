//
//  OTPVerificationView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//

import SwiftUI

struct OTPVerificationView: View {
    @StateObject private var viewModel = OTPVerificationViewModel()
    @Binding var email: String
    @Environment(\.dismiss) private var dismiss
    @Binding var isPasswordRecovery: Bool

    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .center) {
                    Text("Email verification")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 2)
                    
                    Text("Enter the one-time password we just sent you to your email.")
                        .multilineTextAlignment(.center)
                        .font(.system(size: 18))
                        .padding(.bottom)
                        .padding(.horizontal, 25)
                    
                    OneTimeCodeFieldView(
                        otpCode: $viewModel.otpCode,
                    )
                    
                    Button("Submit") {
                        // TODO: ISSUE WITH ERROR HANDLING
                        Task {
                            try await viewModel.emailVerification(email, viewModel.otpCode)
                        }
                    }
                    .buttonStyle(GrowingButtonStyle())
                    .disabled(!viewModel.isFormValid(viewModel.otpCode))
                    .opacity(viewModel.isFormValid(viewModel.otpCode) ? 1 : 0.6)
                    .padding(.top)
                    .navigationDestination(isPresented: $viewModel.passwordRecoveryView, destination: {
                        PasswordRecoveryView()
                            .navigationBarBackButtonHidden(true)
                    })
                    .navigationDestination(isPresented: $viewModel.verificationValid, destination: {
                        MainView()
                    })
                    
                    HStack(alignment: .center) {
                        Text("Didin't received a code?")
                        Button {
                            Task {
                                try await viewModel.resendOtp(email)
                            }
                        } label: {
                            Text("Request again")
                                .underline()
                        }
                    }
                    .padding(.top)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(.primaryBackground.gradient)
//                .alert(isPresented: $viewModel.isVerifyErrorPresented) {
//                    Alert(
//                        title: Text("Verification failed"),
//                        message: Text(viewModel.verifyErrorMessage),
//                        dismissButton: .cancel(Text("OK"))
//                    )
//                }
                .alert(
                    isPresented: $viewModel.showAlert
                ) {
                    viewModel.displayAlert()
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
        }
    }
}



