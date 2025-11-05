//
//  MainView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 23/10/2025.
//

import SwiftUI

struct MainView: View {
    @State private var isLoggedOut = false
    var body: some View {
        NavigationStack {
            VStack {
                Button("Logout") {
                    if KeychainService<String>.delete("jwtToken") {
                        isLoggedOut.toggle()
                    }
                }
                .navigationDestination(isPresented: $isLoggedOut) {
                    SignInView()
                }
            }
        }
    }
}

#Preview {
    MainView()
}
