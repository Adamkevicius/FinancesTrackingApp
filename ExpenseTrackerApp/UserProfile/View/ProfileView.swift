//
//  ProfileView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 10/11/2025.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @EnvironmentObject private var sessionCheck: ClientSessionService
    @FocusState private var isFocused
    
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(alignment: .center) {
                    VStack {
                        // TODO: CHANGE DISABLED LATER
                        // TODO: ADD FIELDS EDIT FUNCTIONALITY
                        SignTextFieldView(title: "Email", inputText: "Enter your email", text: $viewModel.email)
                            .textContentType(.emailAddress)
                            .focused($isFocused)
                            .disabled(true)
                        
                        SignTextFieldView(title: "Full Name", inputText: "Enter your full name", text: $viewModel.fullName)
                            .textContentType(.emailAddress)
                            .focused($isFocused)
                            .disabled(true)
                        
                        SignTextFieldView(title: "Username", inputText: "Enter your username", text: $viewModel.username)
                            .textContentType(.username)
                            .focused($isFocused)
                            .disabled(true)

                        SecuredSignTextFieldView(title: "Passwrod", inputText: "Enter your pasword", text: $viewModel.password)
                        .textContentType(.password)
                        .focused($isFocused)
                        .disabled(true)
                        
                        Button("Edit") {
                            
                        }
                        .buttonStyle(GrowingButtonStyle(
                            buttonColor: .infoButton,
                            textColor: .white,
                            width: 300,
                            height: 50
                        ))
                    }
                    
                    HStack {
                        Button("Upgrade Your Plan") {
                            
                        }
                        .buttonStyle(GrowingButtonStyle(
                            buttonColor: .primaryButtonClr,
                            textColor: .white,
                            width: 200,
                            height: 50
                        ))
                        .disabled(true)
                        
                        Button {
                            let _ = KeychainService<String>.delete("jwtToken")
                            
                            sessionCheck.isLoggedIn = false
                        } label: {
                            Image(systemName: "door.left.hand.open")
                        }
                        .buttonStyle(GrowingButtonStyle(
                            buttonColor: .negativeButton,
                            textColor: .white,
                            width: 100,
                            height: 50
                        ))
                    }
                    .padding(.top, 80)
                    
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBackground)
            .onTapGesture {
                isFocused = false
            }
        }
    }
}

#Preview {
    ProfileView()
}
