//
//  LoginResponse.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 18/10/2025.
//

import Foundation

struct AuthenticationResponse: Codable {
    let success: Bool?
    let httpStatus: String?
    let message: String?
    let date: Date?
}
