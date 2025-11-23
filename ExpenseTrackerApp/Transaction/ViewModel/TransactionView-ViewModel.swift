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
    @Published var amount: String = ""
    @Published var title: String = ""
    @Published var description: String = ""
    
    @Published var firestore = FirestoreService()
    
    var isFormEmpty: Bool {
        amount.isEmpty || title.isEmpty
    }
    
    func createTransaction() async {
        if !isFormEmpty {
            
            let transaction = Transaction(
                type: transactionCategory.rawValue,
                transactionCategory: transactionCategory == .expense ? expenseCategory.rawValue : incomeCategory.rawValue,
                date: occuredOn,
                amount: (amount as NSString).doubleValue,
                title: title,
                description: description,
                userId: KeychainService<String>.get("userId")!
            )
            
            do {
                try await firestore.createDocument(transaction: transaction)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}
