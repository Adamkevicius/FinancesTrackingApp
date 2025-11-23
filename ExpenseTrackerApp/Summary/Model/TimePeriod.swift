//
//  TimePeriod.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 21/11/2025.
//

import Foundation

enum TimePeriod: String, CaseIterable, Identifiable {
    case month = "Month"
    case day = "Day"
    
    var id: Self { self }
}
