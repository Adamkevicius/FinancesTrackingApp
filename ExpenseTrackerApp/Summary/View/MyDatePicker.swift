//
//  MyDatePicker.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 22/11/2025.
//

import SwiftUI

struct MyDatePicker: View {
    @ObservedObject var viewModel: SummaryViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(.black.opacity(0.1))
                .padding(.horizontal, 25)
                .frame(height: 170)

            
            VStack {
                if viewModel.periodValue == .month {
                    YearPicker(currentYear: $viewModel.selectedYear)
                        .padding(.bottom, 10)
                                        
                    MonthPicker(currentMonth: $viewModel.selectedMonth)
                }
                else {
                    YearPicker(currentYear: $viewModel.selectedYear)
                        .padding(.bottom, 10)
                    
                    MonthPicker(currentMonth: $viewModel.selectedMonth)

                    HStack {
                        Text("Day: ")
                        
                        Spacer()
                        
                        Picker("", selection: $viewModel.selectedDay) {
                            ForEach(
                                1...max(viewModel.daysInSelectedMonth, 1),
                                id: \.self
                            ) { month in
                                Text(String(month))
                            }
                        }
                        .tint(.black)
                    }
                    .padding(.top, 10)
                    .padding(.horizontal, 55)
                }
            }
        }
    }
}

#Preview {
    MyDatePicker(viewModel: SummaryViewModel())
}
