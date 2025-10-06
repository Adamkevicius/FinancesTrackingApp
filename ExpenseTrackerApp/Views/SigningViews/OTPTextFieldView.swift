//
//  OTPTextFieldView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//

import SwiftUI

struct OTPTextFieldView: View {
    @Binding var otpCode: String
    
    @FocusState private var isFocused: Bool
    
    @State private var showAlert = false
    
    let onSubmit: () -> Bool
    
    @State private var passwordRecoveryView = false
    
    @State private var notPasswordRevoceryView = false
    
    private var isFormValid: Bool {
        otpCode.count > 0
    }
    
    @Binding var isPasswordRecovery: Bool
    
    @Environment(\.dismiss) private var dismiss
        
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                TextField("", text: $otpCode)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .focused($isFocused)
                    .opacity(0.001)
                    .autocorrectionDisabled(true)
                    .onChange(of: otpCode) { oldValue, newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        otpCode = String(filtered.prefix(6))
                    }
                
                HStack(spacing: 12) {
                    ForEach(0..<6, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(otpCode.count == index ? Color.blue : Color.black, lineWidth: 3)
                                .frame(width: 45, height: 45)
                                                        
                            Text(index < otpCode.count ? String(Array(otpCode)[index]) : "")
                                .font(.title)
                                .bold()
                        }
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    isFocused = true
                }
                
                //  TODO: CHANGE SHEET TO VIEW
                Button("Submit") {
                    if otpCode.count == 6 {
                        if onSubmit() {
                            if isPasswordRecovery {
                                passwordRecoveryView = true
                            }
                            else {
                                notPasswordRevoceryView = true
                                dismiss()
                            }
                            isFocused = false
                        }
                        else {
                            showAlert = true
                        }
                    }
                }
                .buttonStyle(GrowingButtonStyle())
                .disabled(!isFormValid)
                .opacity(isFormValid ? 1 : 0.6)
                .padding(.top, 200)
                .navigationDestination(isPresented: $passwordRecoveryView, destination: {
                    PasswordRecoveryView()
                        .navigationBarBackButtonHidden(true)
                })
                .alert("Wrong Code", isPresented: $showAlert) {
                    Button("OK", role: .cancel) { }
                } message: {
                    Text("The one-time password entered is invalid or expired. Please try again with the latest code.")
                        .multilineTextAlignment(.center)
                        .padding()
                }
            }
        }
    }
}
