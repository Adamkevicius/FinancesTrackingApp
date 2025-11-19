//
//  TransactionCategory.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 17/11/2025.
//

import Foundation

enum TransactionCategory: String, CaseIterable, Identifiable {
    case income = "Income"
    case expense = "Expense"
    
    var id: Self { self }
}
