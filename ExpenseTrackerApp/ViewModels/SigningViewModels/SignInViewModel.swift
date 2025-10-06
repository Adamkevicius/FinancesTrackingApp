//
//  SignInViewModel.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//

import Foundation

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var recoveryBottomSheet = false
    @Published var verificationBottomSheet = false
    @Published var isPasswordRecovery = false
    @Published var isSheetDisappear = false
    
    var isFormValid: Bool {
        email.isEmpty || password.isEmpty
    }
}
