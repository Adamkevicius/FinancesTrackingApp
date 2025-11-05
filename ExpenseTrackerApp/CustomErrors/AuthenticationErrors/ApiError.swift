//
//  ApiError.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 05/11/2025.
//

import Foundation

enum ApiError: Error {
    case invalidUrl
    case invalidData
    case serverInternalError
}
