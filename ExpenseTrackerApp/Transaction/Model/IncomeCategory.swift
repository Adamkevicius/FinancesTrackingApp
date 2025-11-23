//
//  IncomeCategory.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 17/11/2025.
//

import Foundation

enum IncomeCategory: String, CaseIterable, Identifiable {
    case primary = "Primary"
    case investment = "Investment"
    case passive = "Passive"
    case additional = "Addtional"
    
    var id: Self { self }
    
    var name: String {
        switch self {
            case .primary: return "💼"
            case .investment: return "📈"
            case .passive: return "💤"
            case .additional: return "💸"
        }
    }
}
