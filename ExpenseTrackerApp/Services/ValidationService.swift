//
//  ValidationService.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 15/11/2025.
//

import Foundation

class ValidationService {
    func emailValidation(email: String) -> Bool {
        if email.isEmpty { return false }
        
        let emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,64}$"
        let emailPredicate = NSPredicate(format: "SELF MATCHES[c] %@", emailRegex)
        
        if !emailPredicate.evaluate(with: email) { return false }
        
        return true
    }
    
    func usernameValidation(username: String) -> Bool {
        if username.isEmpty { return false }
        
        if username.count < 2 { return false }
        
        let usernameRegex = "^[A-Za-z]+$"
        let usernamePredicate = NSPredicate(format: "SELF MATCHES[c] %@", usernameRegex)
        
        if !usernamePredicate.evaluate(with: username) { return false }
        
        return true
    }
    
    func fullNameValidation(fullName: String) -> Bool {
        if fullName.isEmpty { return false }
        
        if fullName.count < 2 { return false }
        
        guard let firstChar = fullName.first, firstChar.isUppercase else { return false }
        
        let fullNameRegex = "^[A-Za-z ]+$"
        let fullNamePredicate = NSPredicate(format: "SELF MATCHES[c] %@", fullNameRegex)
        
        if !fullNamePredicate.evaluate(with: fullName) { return false }
        
        return true
    }
    
    func passwordValidation(password: String) -> Bool {
        if password.isEmpty { return false }
        
        //  Min 8 char, at least 1 char, 1 num, 1 special char
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*#?&]).{8,}$"
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", passwordRegex)
        
        if !passwordPredicate.evaluate(with: password) { return false }
        
        return true
    }
}
