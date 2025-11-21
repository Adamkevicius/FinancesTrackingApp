//
//  FirestoreService.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 21/11/2025.
//

import Foundation
import FirebaseFirestore

class FirestoreService: ObservableObject {
    private let db = Firestore.firestore()
    private let collectionPath = "transactions"
    
    func createDocument(transaction: Transaction) async throws {
        let transaction = Transaction(
            type: transaction.type,
            transactionCategory: transaction.transactionCategory,
            date: transaction.date,
            amount: transaction.amount,
            title: transaction.title,
            description: transaction.description ?? "",
            userId: transaction.userId
        )
    
        do {
            try db
                .collection(collectionPath)
                .document(transaction.id.uuidString)
                .setData(from: transaction)
        } catch {
            print(error.localizedDescription)
        }
    }
}
