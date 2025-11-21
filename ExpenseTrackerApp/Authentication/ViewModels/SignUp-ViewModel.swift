//
//  SignUpViewModel.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 19/09/2025.
//

import Foundation
import SwiftUI

class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage = ""
    @Published var validationErrorMessage = ""
    

    @Published var bottomSheet = false
    @Published var isPasswordRecovery = false
    @Published var showAlert = false
    
    var signingAlerts: SigningAlerts = .apiError
    
    let validationService = ValidationService()
    
    var isFormEmpty: Bool {
        email.isEmpty || username.isEmpty || password.isEmpty
    }
    
    func isFormValid() -> Bool {
        if !validationService.emailValidation(email: email) ||
           !validationService.usernameValidation(username: username) ||
           !validationService.passwordValidation(password: password)
        {
            self.signingAlerts = .validationError
            self.showAlert = true
            return false
        }
        
        return true
    }
    
    @MainActor
    func signUp() async throws {
        if isFormValid() {
            let signUpRequest = SignUpRequest(email: email, username: username, password: password)
            
            do {
                let signUpResponse = try await AuthService().signUp(
                    requestBody: signUpRequest
                )
                
                if signUpResponse.success {
                    self.bottomSheet = true
                    
                    do {
                        let getUserIdResponse = try await AuthService().getUserId(
                            email: email
                        )
                        
                        KeychainService
                            .set(getUserIdResponse.data, forKey: "userId")

                    } catch {
                        throw ApiError.serverInternalError
                    }
                    
                    KeychainService.set(self.email, forKey: "email")
                    KeychainService.set(self.username, forKey: "username")
                    KeychainService.set("", forKey: "fullName")
                    KeychainService.set(self.password, forKey: "password")
                }
                else {
                    self.errorMessage = signUpResponse.message
                    self.signingAlerts = .apiError
                    self.showAlert = true
                }
            } catch {
                signingAlerts = .serverError
                showAlert = true
            }
        }
    }
    
    func displayAlert() -> Alert {
        switch signingAlerts {
            case .apiError:
                return Alert(
                    title: Text("Sign Up Error."),
                    message: Text(errorMessage),
                    dismissButton: .cancel(Text("OK")))
            case .validationError:
                return Alert(
                    title: Text("Validation error."),
                    message: Text("Invalid sign up credentials. Please try again."),
                    dismissButton: .cancel(Text("OK")))
            case .serverError:
                return Alert(
                    title: Text("Server error."),
                    message: Text("Server connection error."),
                    dismissButton: .cancel(Text("OK")))
        }
    }
}
