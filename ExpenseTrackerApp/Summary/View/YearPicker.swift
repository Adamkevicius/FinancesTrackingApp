//
//  YearPicker.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 22/11/2025.
//

import SwiftUI

struct YearPicker: View {
    @Binding var currentYear: Int
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 50)
                .fill(.white)
                .frame(width: 130, height: 30)
            HStack {
                Image(systemName: "chevron.left")
                    .onTapGesture {
                        currentYear -= 1
                    }
                Text(String(currentYear))
                    .bold()
                
                Image(systemName: "chevron.right")
                    .onTapGesture {
                        currentYear += 1
                    }
            }
        }
    }
}

#Preview {
    YearPicker(currentYear: .constant(Calendar.current.component(.year, from: Date())))
}
