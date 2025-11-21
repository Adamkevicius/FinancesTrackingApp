//
//  OnlyNumbersModifier.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 21/11/2025.
//

import SwiftUI
import Combine

struct OnlyNumbersModifier: ViewModifier {
    
    @Binding var text: String
    
    func body(content: Content) -> some View {
        content
            .keyboardType(.decimalPad)
            .onReceive(Just(text)) { newValue in
                var numbers = "0123456789"
                let decimalSeparator: String = "."
                
                numbers += decimalSeparator
                
                if newValue.components(separatedBy: decimalSeparator).count - 1 > 1 {
                    let filtered = newValue
                    self.text = String(filtered.dropLast())
                }
                else {
                    let filtered = newValue.filter { numbers.contains($0)}
                    if filtered != newValue {
                        self.text = filtered
                    }
                }
            }
    }
    
}

extension View {
    func onlyNumbers(text: Binding<String>) -> some View {
        self.modifier(OnlyNumbersModifier(text: text))
    }
}
