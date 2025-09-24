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
    
    func verifyCode() -> Bool {
        //  TODO: ADD OTP VERIFICATION LOGIC
        return otpCode == "777777"
    }
    
}
