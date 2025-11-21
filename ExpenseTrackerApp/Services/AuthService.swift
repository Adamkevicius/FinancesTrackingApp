//
//  AuthService.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 21/10/2025.
//

import Foundation

class AuthService {
    func createPostRequest(requestURL: String, requestBody: Encodable) async throws -> AuthResponse {
        var request = URLRequest(url: URL(string: requestURL)!)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(requestBody)
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AuthResponse.self, from: data)
        } catch {
            throw ApiError.invalidData
        }
    }
    
    func signUp(requestBody: SignUpRequest) async throws -> AuthResponse {
        return try await createPostRequest(
            requestURL: "http://localhost:8080/api/v1/authentication/signup",
            requestBody: requestBody
        )
    }
    
    func signIn(requestBody: SignInRequest) async throws -> AuthResponse {
        return try await createPostRequest(
            requestURL: "http://localhost:8080/api/v1/authentication/login",
            requestBody: requestBody
        )        
    }
    
    func emailVerification(requestBody: EmailVerificationRequest) async throws -> AuthResponse {
        return try await createPostRequest(
            requestURL: "http://localhost:8080/api/v1/authentication/verification-code/verify",
            requestBody: requestBody
        )
    }
    
    func otpResend(requestBody: OtpResendRequest) async throws -> AuthResponse {
        return try await createPostRequest(
            requestURL: "http://localhost:8080/api/v1/authentication/verification-code/resend",
            requestBody: requestBody
        )
    }
    
    func sessionTokenValidation() async throws -> AuthResponse {
        var request = URLRequest(
            url: URL(
                string: "http://localhost:8080/api/v1/authentication/check-session"
            )!
        )
                
        if let token = KeychainService<String>.get("jwtToken") {
            request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        }
        
        let (data, _) = try await URLSession.shared.data(for: request)
        
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AuthResponse.self, from: data)
        } catch {
            throw ApiError.invalidData
        }
    }
    
    func getUserId(email: String) async throws -> AuthResponse {
        var request = URLRequest(
            url: URL(
                string: "http://localhost:8080/api/v1/user/id/\(email)"
            )!
        )
            
        let (data, _) = try await URLSession.shared.data(for: request)
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode(AuthResponse.self, from: data)
        } catch {
            throw ApiError.invalidData
        }
    }
}
