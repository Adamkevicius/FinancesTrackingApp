//
//  ClientSessionService.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 17/11/2025.
//

import Foundation

class ClientSessionService: ObservableObject {
    @Published var isLoggedIn = false
    
    @MainActor
    func sessionCheck() async throws {
        let sessionCheckResponse = try await AuthService().sessionTokenValidation()
        
        if sessionCheckResponse.success {
            isLoggedIn = true
        }
    }
}
