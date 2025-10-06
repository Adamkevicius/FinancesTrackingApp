//
//  PasswordRecoveryEmailViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 30/09/2025.
//

import Foundation

class PasswordRecoveryEmailViewModel: ObservableObject {
    @Published var email = ""
    @Published var isPresented = false
    @Published var emptyAlert = false
    @Published var wrongEmailAlert = false
    @Published var isPasswordRecovery = false
    var isFormValid: Bool {
        email.isEmpty
    }
    
    func isCorrectEmail() -> Bool {
        //  TODO: CHECK IF EMAIL IF INVALID AND IS IN DATABASE
        return email == "example@gmail.com" ? true : false
    }
}
