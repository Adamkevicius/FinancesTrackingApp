//
//  BottomTabBarView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 10/11/2025.
//

import SwiftUI

struct BottomTabBarView: View {
    @Binding var selectedIndex: Int
    @Binding var isEntryViewShowing: Bool
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.bottomNavBackground)
            
            
            HStack {
                BottomTabBarButton(
                    systemImage: "dollarsign.gauge.chart.lefthalf.righthalf",
                    title: "Summary",
                    action: {
                        selectedIndex = 0
                    },
                    isSelected: selectedIndex == 0
                )
                
                BottomTabBarButton(
                    systemImage: "wallet.bifold", 
                    title: "Wallet",
                    action: {
                        selectedIndex = 1
                    },
                    isSelected: selectedIndex == 1
                )                
                
                UnevenRoundedRectangle(
                    topLeadingRadius: 0,
                    bottomLeadingRadius: 100,
                    bottomTrailingRadius: 100,
                    topTrailingRadius: 0,
                    style: .continuous
                )
                .fill(Color(.primaryBackground))
                .frame(width: 70)
                .padding(.bottom, 50)
                .overlay(alignment: .top) {
                    Button {
                        isEntryViewShowing.toggle()
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 60))
                        
                    }
                    .foregroundStyle(.navMainButton)
                    .offset(y: -30)
                }
                
                BottomTabBarButton(
                    systemImage: "bag.badge.plus",
                    title: "Planing",
                    action: {
                        selectedIndex = 2
                    },
                    isSelected: selectedIndex == 2
                )
                    
                
                BottomTabBarButton(
                    systemImage: "person.crop.circle",
                    title: "Profile",
                    action: {
                        selectedIndex = 3
                    },
                    isSelected: selectedIndex == 3
                )
                
            }
        }
        .frame(height: 90)
    }
}

#Preview {
    BottomTabBarView(
        selectedIndex:
                .constant(0), isEntryViewShowing:
                .constant(false)
    )
}
