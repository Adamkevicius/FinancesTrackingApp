//
//  BottomNavigationView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 10/11/2025.
//

import SwiftUI

struct BottomNavigationView: View {
    @State private var selectedTab = 0
    @State private var isEntryViewShowing = false
    
    var body: some View {
        TabView(selection: $selectedTab) {
            Tab(value: 0) {
                SummaryView()
            }
            
            Tab(value: 1) {
                WalletView()
            }
            
            Tab(value: 2) {
                PlanningView()
            }
            
            Tab(value: 3) {
                ProfileView()
            }
            
        }
        .background(.primaryBackground)
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
        .overlay(alignment: .bottom) {
            BottomTabBarView(
                selectedIndex: $selectedTab,
                isEntryViewShowing: $isEntryViewShowing,
            )
            .offset(y: 35)
        }
        .sheet(isPresented: $isEntryViewShowing) {
            TransactionView()
        }
    }
}

#Preview {
    BottomNavigationView()
}
