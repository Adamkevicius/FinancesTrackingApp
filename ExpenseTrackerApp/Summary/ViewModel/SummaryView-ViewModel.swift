//
//  SummaryView-ViewModel.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 21/11/2025.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class SummaryViewModel: ObservableObject {
    @Published var periodValue: TimePeriod = .month
    @Published var transactionCategory: TransactionCategory = .expense
        
    @Published var selectedYear = Calendar.current.component(.year, from: Date())
    @Published var selectedMonth = Calendar.current.component(.month, from: Date())
    @Published var selectedDay = Calendar.current.component(.day, from: Date())
    
    @Published var firestore = FirestoreService()
    
    @Published var transactions: [Transaction] = []
    @Published var totalExpensesAmount = 0.0
    @Published var totalIncomeAmount = 0.0
    
    var incomeAndExpenseList: [Transaction] = []
    var components = DateComponents()
    var calendar: Calendar { Calendar.current }
    
    var daysInSelectedMonth: Int {
        components.year = calendar.component(.year, from: Date())
        components.month = selectedMonth
        components.day = 1
        
        guard let date =  calendar.date(from: components) else { return 0 }
        
        return calendar.range(of: .day, in: .month, for: date)?
            .count ?? 0
    }
    
    func dateStart() {
        components.year = selectedYear
        components.month = selectedMonth
        components.day = periodValue == .month ? 1 : selectedDay
        
        if let date = Calendar.current.date(from: components) {
            print(date)
        }
    }
    
    func currentMonthRange() -> (start: Date, end: Date)? {
        components.year = selectedYear
        components.month = selectedMonth
        components.day = 1
        
        if let date = calendar.date(from: components) {
            if let monthInterval = calendar.dateInterval(of: .month, for: date) {
                return (monthInterval.start, monthInterval.end)
            }
        }
        return nil
    }
    
    func currentDayRange() -> (start: Date, end: Date)? {
        var components = DateComponents()
        components.year = selectedYear
        components.month = selectedMonth
        components.day = selectedDay
        
        let calendar = Calendar.current
        
        if let date = calendar.date(from: components) {
            let startOfDay = calendar.startOfDay(for: date)
            let endOfDay = calendar.date(
                byAdding: .day,
                value: 1,
                to: startOfDay
            )!
            return (startOfDay, endOfDay)
        }
        
        return nil
    }
    
    func selectrange() -> (start: Date, end: Date)? {
        if periodValue == .month {
            if let monthRange = currentMonthRange() {
                return (monthRange.start, monthRange.end)
            }
        }
        else {
            if let dayRange = currentDayRange() {
                return (dayRange.start, dayRange.end)
            }
        }
        return nil
    }
    
    func fetchTransactions() {
        guard let start = selectrange()?.start else { return }
        guard let end = selectrange()?.end else { return }
        guard let userId = KeychainService<String>.get("userId") else { return }
        
        firestore.fetchTransactions(startDate: start, endDate: end, transactionType: transactionCategory.rawValue, userId: userId) { [weak self] trnsactionsList in
            self?.transactions = trnsactionsList
        }
    }
    
    func fetchTransactionsAmount() {
        guard let start = selectrange()?.start else { return }
        guard let end = selectrange()?.end else { return }
        guard let userId = KeychainService<String>.get("userId") else { return }
        
        firestore.fetchTransactionsAmount(startDate: start, endDate: end, userId: userId) { [weak self] incomeAndExpenses in
            self?.incomeAndExpenseList = incomeAndExpenses
            
            self?.getTotalExpensesAmount()
            self?.getTotalIncomeAmount()
        }
    }
    
    
    
    func reloadDates() {
        if periodValue == .month {
            selectedYear = Calendar.current
                .component(.year, from: Date())
            selectedMonth = Calendar.current
                .component(.month, from: Date())
        }
    }
    
    func getTaskId() -> Int {
        let id: Int = periodValue.hashValue &+
                      selectedYear &+
                      selectedMonth &+
                      selectedDay &+
                      transactionCategory.hashValue
        
        return id
    }
    
    func getTotalExpensesAmount() {
        let expenses =  incomeAndExpenseList
            .filter{ $0.type == "Expense"}
        
        totalExpensesAmount = expenses.map { $0.amount }.reduce(0, +)
    }
    
    func getTotalIncomeAmount() {
        let income =  incomeAndExpenseList
            .filter{ $0.type == "Income"}
        
        totalIncomeAmount = income.map { $0.amount }.reduce(0, +)
    }
}
