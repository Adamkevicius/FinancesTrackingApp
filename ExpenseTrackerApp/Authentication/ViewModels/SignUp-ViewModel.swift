//
//  SignUpViewModel.swift
//  SimpleExpenseTracker
//
//  Created by Matvej Adamkevicius on 19/09/2025.
//

import Foundation

class SignUpViewModel: ObservableObject {
    @Published var email = ""
    @Published var username = ""
    @Published var password = ""
    @Published var errorMessage = ""

    @Published var bottomSheet = false
    @Published var isPasswordRecovery = false
    @Published var isApiErrorMessagePresented = false
    
    var isFormValid: Bool {
        email.isEmpty || username.isEmpty || password.isEmpty
    }
    
    func signUp() async {
        let signUpRequest = SignUpRequest(
            email: email,
            username: username,
            password: password
        )
        
        AuthService().signUp(requestBody: signUpRequest) { success, data in
            
            if success {
                    self.bottomSheet = true
                
                KeychainService.set(self.email, forKey: "email")
                KeychainService.set(self.username, forKey: "username")
                KeychainService.set("", forKey: "fullName")
                KeychainService.set(self.password, forKey: "password")
            }
            else {
                    self.errorMessage = data
                    self.isApiErrorMessagePresented = true
            }
        }
    }
}
