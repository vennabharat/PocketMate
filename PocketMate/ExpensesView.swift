//
//  ExpensesView.swift
//  PocketMate
//
//  Created by bharat venna on 08/03/24.
//

import SwiftUI

struct ExpensesView: View {
    
//    init(){
//        UITableView.appearance().backgroundColor = .clear
//        UITableViewCell.appearance().backgroundColor = .clear
//        UINavigationBar.appearance().largeTitleTextAttributes = [
//            .foregroundColor: UIColor.purple,
//            .font: UIFont(name:"Papyrus", size: 40) ?? UIFont.systemFont(ofSize:40)]
//
//    }
    
    @State private var showAddExpenseView = false
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateAdded, order: .reverse)]) var expenses: FetchedResults<Expense>
    @Environment(\.managedObjectContext) var moc
    
    func remove(at offsets: IndexSet) {
        offsets.map{expenses[$0]}.forEach(moc.delete)
        DataModel.expensesdata.save(context: moc)
    }
    
    func formattedCurrency(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "INR"
        
        return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(gradient: .init(colors: [.indigo, .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        EditButton()
                            .foregroundColor(.red)
                            .frame(width: 50)
                        
                        Spacer()
                        
                        Text("Expenses")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            
                            showAddExpenseView.toggle()
                            
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.orange)
                                .frame(width: 50)
                            
                        }
                    }
//                    .padding(.leading, 10)
//                    .padding(.trailing, 10)
                    
                    Spacer()
                    
                    VStack {
                        List {
                            ForEach(expenses) { item in
                                NavigationLink(destination: ExpenseDetailView(expense: item.expense!, cost: item.cost, category: item.category!, dateAdded: item.dateAdded!, expenseItem: item)) {
                                    HStack {
                                        
                                        VStack(alignment: .leading) {
                                            Text(item.expense!)
                                            Text(item.dateAdded!.formatted(date: .long, time: .omitted))
                                                .font(.system(size: 10))
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.horizontal)
                                        
                                        Spacer()
                                        
                                        HStack {
                                            Text(formattedCurrency(amount: item.cost))
                                            Image(systemName: "arrow.down")
                                                .foregroundColor(.red)
                                        }
                                        .padding(.horizontal)
                                    }
                                    .frame(height: 46)
                                    .background(.ultraThinMaterial)
                                    .cornerRadius(8)
                                }
                            }
                            .onDelete(perform: remove)
                            .listRowBackground(Color.clear)
                            .listRowSeparator(.hidden)
                        }
                        .listStyle(.plain)
                    }
                    
                    Spacer()
                }
            }
            
            .navigationBarHidden(true)
        }
        .sheet(isPresented: $showAddExpenseView) {
            AddExpenseView()
        }
    }
}

struct ExpensesView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ExpensesView()
        }
    }
}
