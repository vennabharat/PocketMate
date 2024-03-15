//
//  IncomeDetailView.swift
//  PocketMate
//
//  Created by bharat venna on 12/03/24.
//

import SwiftUI

struct IncomeDetailView: View {
    
    @State var source: String
    @State var income: Double
    @State var dateAdded: Date
    @State var incomeItem: Income
    
    @State private var showEditView = false
    
    func formattedCurrency(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "INR"
        
        return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    var body: some View {
        ScrollView {
            Image("Income")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width, height: 240)
            
            VStack {
                Text("Income Source: \(source)")
                    .frame(width: UIScreen.main.bounds.width-100)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(.gray, lineWidth: 2)
                    )
                Text("Income: \(formattedCurrency(amount: income))")
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
            }
            .padding(.horizontal)
            
            Spacer()
            
                .navigationTitle("Income")
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
            UpdateIncomeView(source: source, income: income, dateAdded: dateAdded, incomeItem: incomeItem)
        }
    }
}

struct IncomeDetailView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeDetailView(source: "Business", income: 20000.0, dateAdded: Date.now, incomeItem: Income())
    }
}
