//
//  UpdateIncomeView.swift
//  PocketMate
//
//  Created by bharat venna on 14/03/24.
//

import SwiftUI

struct UpdateIncomeView: View {
    
    @State var source: String
    @State var income: Double
    @State var dateAdded: Date
    @State var incomeItem: Income
    
    @FocusState private var keyboardFocus: Bool
    
    @Environment(\.managedObjectContext) var moc
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            
            HStack {
                Button("Cancel", role: .destructive) {
                    dismiss()
                }
                .frame(width: 60)
                
                Spacer()
                
                Text("Add Income")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    
                    DataModel.expensesdata.updateIncome(item: incomeItem, context: moc, source: source, income: income, dateAdded: dateAdded, dateModified: Date.now)
                    dismiss()
                    
                } label: {
                    Text("save")
                        .foregroundColor(.orange)
                        .frame(width: 60)
                }
            }
            .padding(.leading, 10)
            .padding(.trailing, 10)
            .padding(.top, 20)
            
            Spacer()
            
            ScrollView {
                
                TextEditorView(textName: "Income Source", textPlaceholder: "Side Hustle", textValue: $source, valueName: "Income", valuePlaceholder: "0.0", money: $income)
                    .focused($keyboardFocus)
                
                VStack {
                    
                    DatePicker("Please enter a date", selection: $dateAdded, displayedComponents: .date)
                        .labelsHidden()
                        .datePickerStyle(.graphical)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(.gray, lineWidth: 2)
                )
                .cornerRadius(8)
                .padding(.horizontal)
                
                Button {
                    
                    DataModel.expensesdata.updateIncome(item: incomeItem, context: moc, source: source, income: income, dateAdded: dateAdded, dateModified: Date.now)
                    dismiss()
                    
                } label: {
                    Text("Save")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(width: 180, height: 46)
                        .background(.blue)
                        .cornerRadius(8)
                }
            }
            
        }
    }
}

struct UpdateIncomeView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateIncomeView(source: "Job", income: 39500.0, dateAdded: Date.now, incomeItem: Income())
    }
}
