//
//  EmailVerificationRequest.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 21/10/2025.
//

import Foundation

struct EmailVerificationRequest: Codable {
    let email: String
    let verificationCode: String
}
