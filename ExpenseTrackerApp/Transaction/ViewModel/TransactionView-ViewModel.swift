//
//  TransactionView-ViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 17/11/2025.
//

import Foundation

class TransactionViewModel : ObservableObject {
    @Published var transactionCategory: TransactionCategory = .expense
    @Published var expenseCategory: ExpenseCategory = .essentialExpenses
    @Published var incomeCategory: IncomeCategory = .primary
    @Published var occuredOn =  Date.now
    @Published var amount: Int = 0
    @Published var title: String = ""
    @Published var description: String = ""    
}
