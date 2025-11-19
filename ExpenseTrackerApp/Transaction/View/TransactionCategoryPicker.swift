//
//  TransactionCategoryPicker.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 18/11/2025.
//

import SwiftUI

struct TransactionCategoryPicker: View {
    var isExpense: Bool
    @ObservedObject var viewModel: TransactionViewModel

    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.primaryBackground)
                .frame(height: 50)
                .padding(.horizontal, 25)
            HStack {
                Text(isExpense ? "Expense Category" : "Income Category")
                    .font(.system(size: 16))
                    .bold()
                
                Spacer()
                
                if (isExpense) {
                    Picker("", selection: $viewModel.expenseCategory) {
                        ForEach(ExpenseCategory.allCases) { category in
                            Text(category.rawValue)
                        }
                    }
                    .tint(.black)
                }
                else {
                    Picker("", selection: $viewModel.incomeCategory) {
                        ForEach(IncomeCategory.allCases) { category in
                            Text(category.rawValue)
                        }
                    }
                    .tint(.black)
                }
            }
            .padding(.horizontal, 25)
        }
    }
}

#Preview {
    TransactionCategoryPicker(
        isExpense: true,
        viewModel: TransactionViewModel()
    )
}
