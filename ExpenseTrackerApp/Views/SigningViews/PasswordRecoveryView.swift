//
//  PasswordRecoveryView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 29/09/2025.
//

import SwiftUI

struct PasswordRecoveryView: View {
    @StateObject private var viewModel = PasswordRecoeryViewModel()
    
    @Environment(\.dismiss) var dismiss
    
    @FocusState private var isFocused: Bool
        
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 55)
                    .fill(.secondaryBackground)
                    .opacity(0.4)
                    .frame(height: 450)
                    .padding(.horizontal, 25)
                
                VStack {
                    Text("Password Recovery")
                        .font(.title)
                        .bold()
                        .padding(.bottom, 35)
                    
                    SecuredSignTextFieldView(title: "Password", inputText: "Enter a new password", text: $viewModel.password)
                        .focused($isFocused)
                    
                    SecuredSignTextFieldView(title: "Confirm passwrod", inputText: "Confirm a new password", text: $viewModel.confirmPassword)
                        .focused($isFocused)
                    
                    Button("Enter") {
                        if viewModel.isCorrectPassword() {
                            dismiss()
                            dismiss()
                            // TODO ADD COMMUNICATION WITH SERVER ASYNC ALERT
                        }
                        else if viewModel.password.isEmpty {
                            viewModel.emptyPasswordAlert.toggle()
                        }
                        else if viewModel.confirmPassword.isEmpty {
                            viewModel.emptyConfirmPasswordAlert.toggle()
                        }
                        else {
                            viewModel.showAlert.toggle()
                        }
                    }
                    .buttonStyle(GrowingButtonStyle())
                    .disabled(viewModel.isFormValid)
                    .opacity(viewModel.isFormValid ? 0.6 : 1)
                    .padding(.top, 25)
                    .alert("Wrong password", isPresented: $viewModel.showAlert) {
                        Button("Ok", role: .cancel) { }
                    } message: {
                        Text("Passwords are not the same")
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 25)
                    }
                    .padding(.top, 25)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBackground)
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
        .onTapGesture {
            isFocused = false
        }
    }
}

#Preview {
    PasswordRecoveryView()
}
