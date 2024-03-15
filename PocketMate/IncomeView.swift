//
//  IncomeView.swift
//  PocketMate
//
//  Created by bharat venna on 08/03/24.
//

import SwiftUI

struct IncomeView: View {
    
    @State private var showAddIncomeView = false
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateAdded, order: .reverse)]) var income: FetchedResults<Income>
    
    func remove(at offsets: IndexSet) {
        offsets.map{income[$0]}.forEach(moc.delete)
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
                        
                        Text("Income")
                            .font(.title)
                            .fontWeight(.semibold)
                        
                        Spacer()
                        
                        Button {
                            
                            showAddIncomeView.toggle()
                            
                        } label: {
                            Image(systemName: "plus")
                                .foregroundColor(.orange)
                                .frame(width: 50)
                        }
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 10)
                    
                    Spacer()
                    
                    VStack {
                        List {
                            ForEach(income) { item in
                                NavigationLink(destination: IncomeDetailView(source: item.source!, income: item.income, dateAdded: item.dateAdded!, incomeItem: item)) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(item.source!)
                                            Text(item.dateAdded!.formatted(date: .long, time: .omitted))
                                                .font(.system(size: 10))
                                                .foregroundColor(.gray)
                                        }
                                        .padding(.horizontal)
                                        
                                        Spacer()
                                        
                                        HStack {
                                            Text(formattedCurrency(amount: item.income))
                                            Image(systemName: "arrow.up")
                                                .foregroundColor(.green)
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
        .sheet(isPresented: $showAddIncomeView) {
            AddIncomeView()
        }
    }
}

struct IncomeView_Previews: PreviewProvider {
    static var previews: some View {
        IncomeView()
    }
}
