//
//  OTPTextFieldView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 22/09/2025.
//

import SwiftUI

struct OneTimeCodeFieldView: View {    
    @Binding var otpCode: String
    
    @FocusState private var isFocused: Bool
                        
    var body: some View {
        VStack(spacing: 20) {
            ZStack {
                TextField("", text: $otpCode)
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .focused($isFocused)
                    .opacity(0.001)
                    .autocorrectionDisabled(true)
                    .onChange(of: otpCode) { oldValue, newValue in
                        let filtered = newValue.filter { $0.isNumber }
                        otpCode = String(filtered.prefix(6))
                    }
                
                HStack(spacing: 12) {
                    ForEach(0..<6, id: \.self) { index in
                        ZStack {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(otpCode.count == index ? Color.blue : Color.black, lineWidth: 3)
                                .frame(width: 45, height: 45)
                                                        
                            Text(index < otpCode.count ? String(Array(otpCode)[index]) : "")
                                .font(.title)
                                .bold()
                        }
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    isFocused = true
                }
            }
        }
    }
}

