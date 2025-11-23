//
//  ExpenseCategory.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 17/11/2025.
//

import Foundation

enum ExpenseCategory: String, CaseIterable, Identifiable {
    case essentialExpenses = "Essential"
    case financialObligations = "Obligations"
    case lifestyle = "Lifestyle"
    case entertainment = "Entertainment"
    case work = "Work"
    case education = "Education"
    case additional = "Additional"
    
    var id: Self { self }
    
    var name: String {
        switch self {
            case .essentialExpenses: return "🛒"
            case .financialObligations: return "🧾"
            case .lifestyle: return "🛍️"
            case .entertainment: return "🎳"
            case .work: return "💼"
            case .education: return "📚"
            case .additional: return "💸"
        }
    }
}
