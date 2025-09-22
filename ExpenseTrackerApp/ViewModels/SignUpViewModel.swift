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
    
    var isFormValid: Bool {
        email.isEmpty || username.isEmpty || password.isEmpty
    }
    
}
