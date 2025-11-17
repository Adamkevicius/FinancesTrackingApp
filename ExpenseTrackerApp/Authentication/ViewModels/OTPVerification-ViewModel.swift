//
//  OTPVerificationViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//

import Foundation
import SwiftUI

class OTPVerificationViewModel: ObservableObject {
    @Published var otpCode: String = ""
    @Published var verifyErrorMessage = ""
    @Published var resendErrorMessage = ""
    @Published var resendSuccessMessage = ""
    
    @Published var isRecovery: Bool = false
    @Published var verificationValid = false
    @Published var resendOtpCode = false
    @Published var passwordRecoveryView = false
    @Published var notPasswordRevoceryView = false
    @Published var showAlert = false
    var otpVerificationAlerts: OTPVerificationAlerts = .verifyError
    
    func isFormValid(_ otpCode: String) -> Bool {
        return otpCode.count > 0
    }
    
    @MainActor
    func emailVerification(_ email: String, _ otpCode: String) async throws {
        let emailVerificationRequest = EmailVerificationRequest(
            email: email,
            verificationCode: otpCode
        )
        
        if otpCode.count == 6 {
            do {
                let verificationResponse = try await AuthService().emailVerification(
                    requestBody: emailVerificationRequest
                )
                
                if verificationResponse.success {
                    verificationValid = true
                    KeychainService.set(verificationResponse.data, forKey: "jwtToken")
                }
                else {
                    verifyErrorMessage = verificationResponse.message
                    showAlert = true
                    otpVerificationAlerts = .verifyError
                }
            } catch {
                otpVerificationAlerts = .serverError
                showAlert = true
            }
        }
    }
    
    @MainActor
    func resendOtp(_ email: String) async throws  {
        let otpResendRequest = OtpResendRequest(email: email)
        
        let otpResendResponse = try await AuthService().otpResend(requestBody: otpResendRequest)
        
        if otpResendResponse.success {
            self.resendSuccessMessage = otpResendResponse.message
            showAlert = true
            otpVerificationAlerts = .resendSuccess
        }
        else {
            self.resendErrorMessage = otpResendResponse.message
            showAlert = true
            otpVerificationAlerts = .resendError
        }
    }
    
    func displayAlert() -> Alert {
        switch otpVerificationAlerts {
            case .verifyError:
                return Alert(
                    title: Text("Verification error."),
                    message: Text(verifyErrorMessage),
                    dismissButton: .cancel(Text("OK")))
            case .resendSuccess:
                return Alert(
                    title: Text("OTP sended successfully!"),
                    message: Text(resendSuccessMessage),
                    dismissButton: .cancel(Text("OK")))
            case .resendError:
                return Alert(
                    title: Text("Otp resend failed."),
                    message: Text(resendErrorMessage),
                    dismissButton: .cancel(Text("OK")))
            case .serverError:
                return Alert(
                    title: Text("Server Error."),
                    message: Text(resendErrorMessage),
                    dismissButton: .cancel(Text("OK")))
        }
    }
}
