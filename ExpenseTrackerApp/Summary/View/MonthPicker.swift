//
//  MonthPicker.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 22/11/2025.
//

import SwiftUI

struct MonthPicker: View {
    @Binding var currentMonth: Int
    var body: some View {
        Divider()
            .frame(width: 300)
            .background(Color.black)
        
        ScrollViewReader { proxy in
            ScrollView(.horizontal) {
                HStack {
                    ForEach(1...12, id: \.self) { month in
                        Text(
                            DateFormatter().shortMonthSymbols[month - 1]
                        )
                        .id(month)
                        .foregroundStyle(
                            month == currentMonth ? .primaryButtonClr : .primaryTextClr
                        )
                        .onTapGesture {
                            currentMonth = month
                        }
                    }
                }
                
                
            }
            .scrollIndicators(.never)
            .padding(.horizontal, 65)
            .onAppear {
                withAnimation {
                    proxy
                        .scrollTo(
                            currentMonth,
                            anchor: .center
                        )
                }
            }
        }
        
        Divider()
            .frame(width: 300)
            .background(Color.black)
    }
}

#Preview {
    MonthPicker(
        currentMonth: .constant(Calendar.current.component(.month, from: Date()))
    )
}
