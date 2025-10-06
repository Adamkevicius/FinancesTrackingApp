//
//  OTPVerificationView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//

import SwiftUI

struct OTPVerificationView: View {
    @StateObject private var viewModel = OTPVerificationViewModel()
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
                        .padding(.bottom, -150)
                        .padding(.horizontal, 25)
                    
                    OTPTextFieldView(otpCode: $viewModel.otpCode, onSubmit: viewModel.verifyCode, isPasswordRecovery: $isPasswordRecovery)
                        
                    
                    HStack(alignment: .center) {
                        Text("Didin't received a code?")
                        Button {
                            //  TODO: ADD OTP REQUEST AGAIN CODE
                        } label: {
                            Text("Request again")
                                .underline()
                        }
                    }
                    .padding(.top)
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
                .background(.primaryBackground.gradient)
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
