//
//  ExpenseDetailView.swift
//  PocketMate
//
//  Created by bharat venna on 12/03/24.
//

import SwiftUI

struct ExpenseDetailView: View {
    
    @State var expense: String
    @State var cost: Double
    @State var category: String
    @State var dateAdded: Date
    @State var expenseItem: Expense
    
    @State private var showEditView = false
    
    func formattedCurrency(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "INR"
        
        return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    var body: some View {
        VStack {
            VStack {
                Image(category)
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width, height: 240)
                
                VStack {
                    Text("Expense: \(expense)")
                        .frame(width: UIScreen.main.bounds.width-100)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 2)
                        )
                    Text("Cost: \(formattedCurrency(amount: cost))")
                        .frame(width: UIScreen.main.bounds.width-100)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 2)
                        )
                    Text("Category: \(category)")
                        .frame(width: UIScreen.main.bounds.width-100)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 2)
                        )
                    Text("Added on: \(dateAdded.formatted(date: .abbreviated, time: .omitted))")
                        .frame(width: UIScreen.main.bounds.width-100)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 2)
                        )
                    
                    if(expenseItem.dateModified != nil) {
                        Text("Modified on: \(expenseItem.dateModified!.formatted(date: .abbreviated, time: .omitted))")
                            .frame(width: UIScreen.main.bounds.width-100)
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(.gray, lineWidth: 2)
                            )
                    }
                }
                .padding(.horizontal)
            }
            
            Spacer()
            
                .navigationTitle("\(category)")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button {
                            showEditView.toggle()
                        } label: {
                            HStack(spacing: 0) {
                                Image(systemName: "pencil")
                                    .font(.system(size: 15))
                                Text("Edit")
                            }
                        }
                    }
                }
        }
        .sheet(isPresented: $showEditView) {
            UpdateExpenseView(expense: $expense, cost: $cost, dateAdded: $dateAdded, category: $category, expenseItem: $expenseItem)
        }
        
        
    }
}

struct ExpenseDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseDetailView(expense: "Coffee", cost: 20.0, category: "Office", dateAdded: Date.now, expenseItem: Expense())
    }
}
