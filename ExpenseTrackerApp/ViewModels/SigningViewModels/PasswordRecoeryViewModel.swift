//
//  PasswordRecoeryViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 29/09/2025.
//

import Foundation
import SwiftUI

class PasswordRecoeryViewModel: ObservableObject {
    @Published var password = ""
    @Published var confirmPassword = ""
    @Published var showAlert = false
    @Published var emptyPasswordAlert = false
    @Published var emptyConfirmPasswordAlert = false
    static var alertMessage = Notification.Name("Password changes successfully")
    var isFormValid: Bool {
        password.isEmpty || confirmPassword.isEmpty
    }

    
    func isCorrectPassword() -> Bool {
        return !password.isEmpty && !confirmPassword.isEmpty && password == confirmPassword ? true : false
    }
}
