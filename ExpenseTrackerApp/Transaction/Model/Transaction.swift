//
//  Transaction.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 21/11/2025.
//

import Foundation
import FirebaseFirestore

struct Transaction: Codable, Identifiable {
    var id = UUID()
    
    var type: String
    var transactionCategory: String
    var date: Date
    var amount: Double
    var title: String
    var description: String?
    var userId: String
}
