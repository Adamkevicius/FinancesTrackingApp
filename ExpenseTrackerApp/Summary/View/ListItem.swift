//
//  ListItem.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 22/11/2025.
//

import SwiftUI

struct ListItem: View {
    
    var transaction: Transaction
    
    var body: some View {
        ZStack {
            HStack {
                ZStack {
                    Circle()
                        .fill(.black.opacity(0.1))
                        .frame(width: 33)
                    if transaction.type == "Expense" {
                        if let categoryName = ExpenseCategory(rawValue: transaction.transactionCategory) {
                            Text(categoryName.name)
                                .padding(.bottom, 5)
                        }
                    }
                    else {
                        if let categoryName = IncomeCategory(rawValue: transaction.transactionCategory) {
                            Text(categoryName.name)
                                .padding(.bottom, 5)
                        }
                    }
                }
                Text(transaction.title)
                    .bold()
                    .padding(.leading, 5)
                
                Spacer()
                
                Text(String(transaction.amount))
                    .bold()
                    .foregroundStyle(transaction.type == "Expense" ? .negativeButton : .navMainButton)
            }
            .padding()
        }
        .background(.secondaryBackground.opacity(0.5))
        .clipShape(.rect(cornerRadius: 20))
    }
}

#Preview {
    ListItem(
        transaction: Transaction(
            type: "Expense",
            transactionCategory: "Primary",
            date: Date.now,
            amount: 100.0,
            title: "Test",
            userId: "2"
        )
    )
}
