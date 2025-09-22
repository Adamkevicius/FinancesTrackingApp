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
    
    var isFormValid: Bool {
        email.isEmpty || password.isEmpty
    }
}
