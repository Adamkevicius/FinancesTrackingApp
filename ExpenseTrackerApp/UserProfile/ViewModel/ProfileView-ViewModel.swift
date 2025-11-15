//
//  ProfileView-ViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 12/11/2025.
//

import Foundation

class ProfileViewModel: ObservableObject {
    @Published var email = KeychainService<String>.get("email") ?? ""
    @Published var username = KeychainService<String>.get("username") ?? ""
    @Published var fullName = KeychainService<String>.get("fullName") ?? "Enter your full name"
    @Published var password = KeychainService<String>.get("password") ?? ""
}
