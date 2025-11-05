//
//  AuthService.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 21/10/2025.
//

import Foundation

class AuthService {
    
    func signUp(requestBody: SignUpRequest, completion: @escaping (Bool, String) -> Void) {
        
        guard let url = URL(string: "http://localhost:8080/authentication/signup") else {
            completion(false, "Invalid URL.")
            return
        }
        
        let body = requestBody
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(body)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {
                completion(false, "Failed to fetch the data.")
                return
            }
            
            if let signUpResponse = try? JSONDecoder().decode(
                AuthResponse.self,
                from: data
            ) {
                let success = signUpResponse.success
                
                if success {
                    completion(success, signUpResponse.data ?? "Failed to fetch data.")
                }
                else {
                    completion(success, signUpResponse.message)
                }
            }
            else {
                completion(false, "Server internal error.")
            }
            
        }.resume()
    }
    
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
    
    func signIn(requestBody: SignInRequest) async throws -> AuthResponse {
        return try await createPostRequest(
            requestURL: "http://localhost:8080/authentication/login",
            requestBody: requestBody
        )        
    }
    
    func emailVerification(requestBody: EmailVerificationRequest) async throws -> AuthResponse {
        return try await createPostRequest(
            requestURL: "http://localhost:8080/authentication/verification-code/verify",
            requestBody: requestBody
        )
    }
    
    func otpResend(requestBody: OtpResendRequest) async throws -> AuthResponse {
        return try await createPostRequest(
            requestURL: "http://localhost:8080/authentication/verification-code/resend",
            requestBody: requestBody
        )
    }
    
    func sessionTokenValidation() async throws -> AuthResponse {
        var request = URLRequest(
            url: URL(
                string: "http://localhost:8080/authentication/check-session"
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
}
