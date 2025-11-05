//
//  SignInViewModel.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//

import Foundation
import SwiftUI

class SignInViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    @Published var recoveryBottomSheet = false
    @Published var isAuthenticated = false
    @Published var isPasswordRecovery = false
    @Published var isFormValid = false
    @Published var isApiErrorMessagePresented = false
    
    
    var isFormEmpty: Bool {
        email.isEmpty || password.isEmpty
    }
    
    // TODO: HANDLE ERRORS
    @MainActor
    func signIn() async throws {
        let signInRequest = SignInRequest(email: email, password: password)
        
        do {
            let authResponse = try await AuthService().signIn(requestBody: signInRequest)
                
            if authResponse.success {
                isAuthenticated = true
            }
            else {
                errorMessage = authResponse.message
                isApiErrorMessagePresented = true
            }
        } catch ApiError.serverInternalError {
            errorMessage = "Could not connect to the server."
            isApiErrorMessagePresented = true
        }
    }
}
