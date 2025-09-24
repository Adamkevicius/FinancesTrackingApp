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
    @Published var bottomSheet = false
    
    var isFormValid: Bool {
        email.isEmpty || password.isEmpty
    }
}
