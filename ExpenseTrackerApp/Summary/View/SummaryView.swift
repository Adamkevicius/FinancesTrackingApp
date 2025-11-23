//
//  SummaryView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 23/10/2025.
//

import SwiftUI

struct SummaryView: View {
    @StateObject private var viewModel = SummaryViewModel()
    
    private let months: [String] = Calendar.current.shortMonthSymbols

    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    Picker("", selection: $viewModel.periodValue) {
                        ForEach(TimePeriod.allCases) { value in
                            Text(value.rawValue)
                                .bold()
                        }
                    }
                    .pickerStyle(.segmented)
                    .padding(.horizontal, 100)
                    
                    MyDatePicker(viewModel: viewModel)
                        .padding(.vertical, 20)
                    
                    ScrollView {
                        Picker("", selection: $viewModel.transactionCategory) {
                            ForEach(TransactionCategory.allCases) { category in
                                Text(category.rawValue)
                            }
                        }
                        .padding(.horizontal, 25)
                        .padding(.bottom, 10)
                        .pickerStyle(.segmented)
                        
                        HStack(spacing: 30) {
                            VStack {
                                Text("Total Expenses:")
                                    .bold()
                                Text(String(format: "%g", viewModel.totalExpensesAmount))
                                    .bold()
                                    .foregroundStyle(.negativeButton)
                            }
                            
                            Divider()
                                .frame(width: 1, height: 50)
                                .background(Color.black)
                                
                            
                            VStack {
                                Text("Total Income:")
                                    .bold()
                                Text(String(format: "%g", viewModel.totalIncomeAmount))
                                    .bold()
                                    .foregroundStyle(.navMainButton)
                            }
                            
                        }
                        .frame(width: 350, height: 60)
                        .background(.black.opacity(0.1))
                        .clipShape(.rect(cornerRadius: 10))
                        
                        GeometryReader { g in
                            List {
                                ForEach(viewModel.transactions) { transaction in
                                    ListItem(transaction: transaction)
                                        .listRowSeparator(.hidden)
                                        .listRowBackground(Color(.primaryBackground))
                                }
                            }
                            .padding(.horizontal, 25)
                            .listStyle(.plain)
                            .background(.primaryBackground)
                            .scrollIndicators(.never)
                        }
                        .background(Color(.black))
                        .frame(height: 400)
                    }
                    .padding(.bottom, 80)
                    .scrollIndicators(.never)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBackground)
            .task(id: viewModel.getTaskId()) {
                viewModel.fetchTransactions()
                viewModel.fetchTransactionsAmount()
            }
            .onChange(of: viewModel.periodValue) {
                viewModel.reloadDates()
            }
        }
    }
}

#Preview {
    SummaryView()
}
