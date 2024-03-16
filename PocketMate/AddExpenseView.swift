//
//  AddExpenseView.swift
//  PocketMate
//
//  Created by bharat venna on 08/03/24.
//

import SwiftUI

struct AddExpenseView: View {
    
    @Environment(\.dismiss) var dismiss
    
    let categories = ["Food", "Home Needs", "Shopping", "Personal", "Office", "Business"]
    
    @State private var symbol = false
    
    @State private var expense = ""
    @State private var cost = 0.0
    @State private var dateAdded = Date.now
    @State private var category = "Home Needs"
    
    @FocusState private var keyboardFocus: Bool
    
    @Environment(\.managedObjectContext) var moc
    
    var body: some View {
        VStack {
            
            HStack {
                Button("Cancel", role: .destructive) {
                    dismiss()
                }
                .frame(width: 60)
                
                Spacer()
                
                Text("Add Expense")
                    .font(.title2)
                    .fontWeight(.semibold)
                
                Spacer()
                
                Button {
                    
                    DataModel.expensesdata.createExpense(context: moc, expense: expense, dateAdded: dateAdded, cost: cost, category: category)
                    dismiss()
                    
                } label: {
                    Text("save")
                        .foregroundColor(.orange)
                        .frame(width: 60)
                }
            }
//            .padding(.leading, 10)
//            .padding(.trailing, 10)
            .padding(.top, 20)
            
            Spacer()
            
            ScrollView {
                
                TextEditorView(textName: "Expense Name", textPlaceholder: "Choclates", textValue: $expense, valueName: "Cost", valuePlaceholder: "0.0", money: $cost)
                    .focused($keyboardFocus)
                
                VStack {
                        HStack {
                            Text("Select Category:")
                                .font(.system(size: 20))
                                .fontWeight(.semibold)
                                .padding(.horizontal)
                            Spacer()
                            
                            HStack {
                                Picker("Select Category", selection: $category) {
                                    ForEach(categories, id: \.self) {
                                        Text($0)
                                    }
                                }
                                
                                Image(systemName: "chevron.down")
                            }
                            .padding(.horizontal)
                        }
                        .frame(width: UIScreen.main.bounds.width-15, height: 46)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 2)
                        )
                        .padding()
                        
                    
                }
                
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
                    DataModel.expensesdata.createExpense(context: moc, expense: expense, dateAdded: dateAdded, cost: cost, category: category)
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

struct AddExpenseView_Previews: PreviewProvider {
    static var previews: some View {
        AddExpenseView()
    }
}
