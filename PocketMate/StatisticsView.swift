//
//  StatisticsView.swift
//  PocketMate
//
//  Created by bharat venna on 08/03/24.
//

import SwiftUI

struct StatisticsView: View {
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateAdded, order: .reverse)]) var expenses: FetchedResults<Expense>
    
    @FetchRequest(sortDescriptors: [SortDescriptor(\.dateAdded, order: .reverse)]) var income: FetchedResults<Income>
    
    let availableMonths = ["Total 2024", "Jan 2024", "Feb 2024", "Mar 2024", "Apr 2024", "May 2024", "Jun 2024", "Jul 2024", "Aug 2024", "Sep 2024", "Oct 2024", "Nov 2024", "Dec 2024"]
    
    @State private var selectedMonth = ""
    
    @State private var monthlyExpensesTotal = [String : Double]()
    @State private var monthlyIncomeTotal = [String : Double]()
    
    var body: some View {
        NavigationView {
            ZStack {
                
                LinearGradient(gradient: .init(colors: [.indigo, .black]), startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    HStack {
                        Text("Summary")
                            .font(.title3)
                            .fontWeight(.bold)
                    }
                    
                    ScrollView {
                          
                        HStack {
                            
                            Text("Your income:")
                                .padding(.leading)
                            
                            Spacer()
                            HStack {
                                Picker("Select Month", selection: $selectedMonth) {
                                    ForEach(availableMonths, id: \.self) {
                                        Text($0)
                                            .font(.system(size: 10))
                                            .fontWeight(.semibold)
                                    }
                                }
                                
                                Image(systemName: "chevron.down")
                                    .foregroundColor(.blue)
                            }
                            .frame(width: 110, height: 16)
                            .background(.ultraThickMaterial)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(.white, lineWidth: 1)
                            )
                            
                            Text(formattedCurrency(amount: monthlyIncomeTotal[selectedMonth] ?? 0.0))
//                            Text("\(monthlyIncomeTotal[selectedMonth] ?? 0.0)")
                                .padding(.trailing)
                        }
                        .frame(width: UIScreen.main.bounds.width-15, height: 46)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 2)
                        )
                        
                        HStack {
                            
                            Text("Your expenses:")
                                .padding(.leading)
                            
                            Spacer()
//                            Text("\(expensesTotal())")
                            Text(formattedCurrency(amount: monthlyExpensesTotal[selectedMonth] ?? 0.0))
                                .padding(.horizontal)
                        }
                        .frame(width: UIScreen.main.bounds.width-15, height: 46)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(.gray, lineWidth: 2)
                        )

                    }
                    
                    Spacer()
                }
            }
            .preferredColorScheme(.dark)
            .navigationBarHidden(true)
            .onAppear(perform: refreshMonthYear)
            .onAppear(perform: getMonthlyExpensesTotal)
            .onAppear(perform: getMonthlyIncomeTotal)
            .onAppear(perform: getMonthlyTotal)
        }
    }
    
    func getMonthlyTotal() {
        
        var incomeTotal = 0.0
        var expensesTotal = 0.0
        
        for item in expenses {
            expensesTotal += item.cost
        }
        
        for item in income {
            incomeTotal += item.income
        }
        
        monthlyIncomeTotal["Total 2024"] = incomeTotal
        monthlyExpensesTotal["Total 2024"] = expensesTotal
    }
    
    func getMonthlyIncomeTotal() {
        
        for month in availableMonths {
            
            monthlyIncomeTotal["\(month)"] = 0.0
            
            for item in income {
                
                let itemMonth = item.dateAdded?.formatted(date: .abbreviated, time: .omitted)
                
                if itemMonth!.contains(month) == true {
                    
                    monthlyIncomeTotal["\(month)"]! += item.income
                    
                }
            }
        }
    }
    
    func getMonthlyExpensesTotal() {
        
        for month in availableMonths {
            
            monthlyExpensesTotal["\(month)"] = 0.0
            
            for item in expenses {
                
                let itemMonth = item.dateAdded?.formatted(date: .abbreviated, time: .omitted)
                
                if itemMonth!.contains(month) == true {
                    
                    monthlyExpensesTotal["\(month)"]! += item.cost
                    
                }
            }
        }
        
    }
    
    func refreshMonthYear() {
        let presentDate = Date.now.formatted(date: .abbreviated, time: .omitted)
        
        for month in availableMonths {
            if presentDate.contains(month) {
                selectedMonth = month
            }
        }
    }
    
    func formattedCurrency(amount: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencyCode = "INR"
        return numberFormatter.string(from: NSNumber(value: amount)) ?? ""
    }
    
    func expensesTotal() -> String {
        
        var total = 0.0
        
        for item in expenses {
            
            total += item.cost
        }
        
        return formattedCurrency(amount: total)
    }
    
    func incomeTotal() -> String {
        
        var total = 0.0
        
        for item in income {
            
            total += item.income
        }
        
        return formattedCurrency(amount: total)
    }
    
}

struct StatisticsView_Previews: PreviewProvider {
    static var previews: some View {
        StatisticsView()
    }
}
