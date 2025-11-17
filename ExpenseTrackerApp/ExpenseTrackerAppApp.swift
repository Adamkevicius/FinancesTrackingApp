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
                BottomNavigationView()
                    .environmentObject(sessionCheck)
            }
            else {
                SignInView()
                    .environmentObject(sessionCheck)
            }
        }
    }
}
