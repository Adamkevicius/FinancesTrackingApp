//
//  ExpenseTrackerAppApp.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//

import SwiftUI

@main
struct ExpenseTrackerAppApp: App {
    @StateObject private var sessionCheck = ClientSessionService()
    var body: some Scene {
        WindowGroup {
            if sessionCheck.isLoggedIn {
                MainView()
            }
            else {
                SignInView()
            }
        }
    }
}

class ClientSessionService: ObservableObject {
    @Published var isLoggedIn = false
    
    
    init() {
        Task(priority: .high) {
            try await sessionCheck()
        }
    }
    
    @MainActor
    func sessionCheck() async throws {
        let sessionCheckResponse = try await AuthService().sessionTokenValidation()
        
        if sessionCheckResponse.success {
            isLoggedIn = true
        }
    }
}
