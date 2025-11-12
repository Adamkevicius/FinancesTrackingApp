//
//  BottomTabBarButton.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 10/11/2025.
//

import SwiftUI

struct BottomTabBarButton: View {
    let systemImage: String
    let title: String
    let action: () -> Void
    let isSelected: Bool
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: systemImage)
                    .font(.system(size: 25))
                Text(title)
                    .font(.system(size: 10))
                    .fontWeight(.bold)
            }
            .padding(.horizontal)
            .foregroundStyle(isSelected ? .green : .navInactive)
        }
    }
}

#Preview(traits: .sizeThatFitsLayout) {
    BottomTabBarButton(
        systemImage: "dollarsign.gauge.chart.lefthalf.righthalf",
        title: "Summary",
        action: {},
        isSelected: false
    )
}
