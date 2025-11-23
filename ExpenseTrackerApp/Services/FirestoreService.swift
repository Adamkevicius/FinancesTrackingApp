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
                .collection(collectionPath).document()
                .setData(from: transaction)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchTransactions(startDate: Date, endDate: Date, transactionType: String, userId: String, completion: @escaping (_ trnsactions: [Transaction]) -> Void
    ) {
        db.collection(collectionPath)
            .whereField("date", isGreaterThan: startDate)
            .whereField("date", isLessThan: endDate)
            .whereField("type", isEqualTo: transactionType)
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                return
            }
            
            let transactions: [Transaction] = documents.compactMap { try? $0.data(as: Transaction.self) }
            completion(transactions)
        }
    }
    
    func fetchTransactionsAmount(startDate: Date, endDate: Date, userId: String, completion: @escaping (_ trnsactions: [Transaction]) -> Void
    ) {
        db.collection(collectionPath)
            .whereField("date", isGreaterThan: startDate)
            .whereField("date", isLessThan: endDate)
            .whereField("userId", isEqualTo: userId)
            .addSnapshotListener { querySnapshot, error in
                guard let documents = querySnapshot?.documents else {
                    return
                }
                
                let transactions: [Transaction] = documents.compactMap { try? $0.data(as: Transaction.self) }

                completion(transactions)
            }
    }
}
