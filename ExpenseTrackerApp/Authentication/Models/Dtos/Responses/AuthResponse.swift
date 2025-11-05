//
//  AuthResponse.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 21/10/2025.
//

import Foundation

struct AuthResponse: Codable {
    let success: Bool
    let message: String
    let data: String?
}
