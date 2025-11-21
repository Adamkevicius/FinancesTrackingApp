//
//  TransactionView.swift
//  ExpenseTrackerApp
//
//  Created by Matvej Adamkevicius on 10/11/2025.
//

import SwiftUI

struct TransactionView: View {
    @StateObject private var viewModel = TransactionViewModel()
    
    @Environment(\.dismiss) private var dismiss
    
    @FocusState private var isFocused: Bool
        
    var body: some View {
        ZStack {
            Button {
                dismiss()
            } label: {
                Image(systemName: "xmark.circle.fill")
                    .font(.title)
                    .foregroundStyle(.black)
            }
            .frame(
                maxWidth: .infinity,
                maxHeight: .infinity,
                alignment: .topLeading
            )
            .padding([.top, .leading], 25)
            
            VStack {
                VStack(spacing: 15) {
                    Picker(
                        "", selection: $viewModel.transactionCategory
                    ) {
                        ForEach(TransactionCategory.allCases) { category in
                            Text(category.rawValue)
                        }
                    }
                    .pickerStyle(.segmented)
                    .background(.primaryBackground)
                    .padding(.horizontal, 25)
                    .padding(.top, 90)
                    
                    if viewModel.transactionCategory == .expense {
                        TransactionCategoryPicker(
                            isExpense: true,
                            viewModel: viewModel
                        )
                    }
                    else {
                        TransactionCategoryPicker(
                            isExpense: false,
                            viewModel: viewModel
                        )
                    }
                    
                    DatePicker("Date & Time", selection: $viewModel.occuredOn)
                        .padding(.horizontal, 25)
                        .bold()
                }
                
                Spacer()
                            
                VStack {
                    TextField("0", text: $viewModel.amount)
                        .onlyNumbers(text: $viewModel.amount)
                        .font(.system(size: 80))
                        .multilineTextAlignment(.center)
                        .padding([.bottom, .top], 50)
                        .tint(.clear)
                        .focused($isFocused)
                    
                    Spacer()
                    
                    VStack {
                        Text("Title")
                            .font(.system(size: 16))
                            .padding(.trailing, 310)
                            .bold()
                        
                        TextField(
                            "",
                            text: $viewModel.title,
                        )
                            .padding(10)
                            .background(.textFieldBackground)
                            .brightness(0.4)
                            .cornerRadius(10)
                            .padding(.horizontal, 25)
                            .padding(.bottom, 25)
                            .bold()
                            .focused($isFocused)
                        
                        Text("Description")
                            .font(.system(size: 16))
                            .padding(.trailing, 250)
                            .bold()
                        
                        
                        TextEditor(
                            text: $viewModel.description,
                        )
                            .padding(.horizontal, 10)
                            .frame(height: 100)
                            .background(.textFieldBackground)
                            .brightness(0.4)
                            .cornerRadius(10)
                            .padding(.horizontal, 25)
                            .padding(.bottom, 25)
                            .lineLimit(1...5)
                            .bold()
                            .focused($isFocused)
                        
                        Button("Add") {
                            Task {
                                await viewModel.createTransaction()
                            }
                        }
                        .buttonStyle(
                            GrowingButtonStyle(
                                buttonColor: viewModel.isFormEmpty ? .primaryButtonClr
                                    .opacity(0.45) : .primaryButtonClr,
                                textColor: .primaryTextClr,
                                width: 350,
                                height: 50
                            )
                        )
                        .disabled(viewModel.isFormEmpty ? true : false)
                    }
                }
                .padding(.bottom)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.primaryBackground)
        .onTapGesture {
            isFocused = false
        }
    }

}

#Preview {
    TransactionView()
}
