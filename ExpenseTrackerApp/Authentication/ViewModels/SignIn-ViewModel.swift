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
    @Published var showAlert = false
    
    var signingAlerts: SigningAlerts = .apiError
    
    let validationService = ValidationService()
    
    var isFormEmpty: Bool {
        email.isEmpty || password.isEmpty
    }
    
    func isFormValid() -> Bool {
        if !validationService.emailValidation(email: email) ||
           !validationService.passwordValidation(password: password)
        {
            self.signingAlerts = .validationError
            self.showAlert = true
            return false
        }
        
        return true
    }
    
    @MainActor
    func signIn() async throws {
        if isFormValid() {
            let signInRequest = SignInRequest(email: email, password: password)
            
            do {
                let authResponse = try await AuthService().signIn(requestBody: signInRequest)
                
                if authResponse.success {
                    isAuthenticated = true
                }
                else {
                    errorMessage = authResponse.message
                    signingAlerts = .apiError
                    showAlert = true
                }
            } catch {
                errorMessage = "Server connection error."
                signingAlerts = .apiError
                showAlert = true
            }
        }
    }
    
    func displayAlerts() -> Alert {
        switch signingAlerts {
            case .apiError:
                return Alert(
                    title: Text("Sign In Error"),
                    message: Text(errorMessage),
                    dismissButton: .cancel(Text("OK"))
                )
            case .validationError:
                return Alert(
                    title: Text("Validation Error"),
                    message: Text("Invalid sign in credentials. Please try again."),
                    dismissButton: .cancel(Text("OK"))
                )
        }
    }
}
