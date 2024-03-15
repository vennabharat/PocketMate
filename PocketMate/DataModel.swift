//
//  DataModel.swift
//  PocketMate
//
//  Created by bharat venna on 08/03/24.
//

import Foundation
import CoreData

class DataModel: ObservableObject {
    
    static let expensesdata = DataModel()
    
    let container = NSPersistentContainer(name: "DataModel")
    
    init() {
        container.loadPersistentStores { description, error in
            
            if let error = error {
                print("Failed to load Core Data: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print("Error saving to Core Data: \(error.localizedDescription)")
        }
    }
    
    func createExpense(context: NSManagedObjectContext, expense: String, dateAdded: Date, cost: Double, category: String) {
        
        let item = Expense(context: context)
        
        item.id = UUID()
        item.expense = expense
        item.category = category
        item.cost = cost
        item.dateAdded = dateAdded
        
        save(context: context)
    }
    
    func createIncome(context: NSManagedObjectContext, source: String, income: Double, dateAdded: Date) {
        
        let item = Income(context: context)
        
        item.id = UUID()
        item.source = source
        item.income = income
        item.dateAdded = dateAdded
        
        save(context: context)
    }
    
    func updateExpense(item: Expense, context: NSManagedObjectContext, expense: String, dateAdded: Date, cost: Double, category: String, dateModified: Date) {
        
        item.expense = expense
        item.category = category
        item.cost = cost
        item.dateAdded = dateAdded
        item.dateModified = dateModified
        
        save(context: context)
    }
    
    func updateIncome(item: Income, context: NSManagedObjectContext, source: String, income: Double, dateAdded: Date, dateModified: Date) {
        
        item.source = source
        item.income = income
        item.dateAdded = dateAdded
        item.dateModified = dateModified
        
        save(context: context)
    }
}
