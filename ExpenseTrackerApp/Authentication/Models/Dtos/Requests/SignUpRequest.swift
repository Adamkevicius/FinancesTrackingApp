//
//  SignUpRequest.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 21/10/2025.
//

import Foundation

struct SignUpRequest: Codable {
    let email: String
    let username: String
    let password: String
}
