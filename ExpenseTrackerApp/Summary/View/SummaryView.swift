//
//  SummaryView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 23/10/2025.
//

import SwiftUI

struct SummaryView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Text("SummaryView")
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.primaryBackground)
        }
    }
}

#Preview {
    SummaryView()
}
