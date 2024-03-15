//
//  PocketMateApp.swift
//  PocketMate
//
//  Created by bharat venna on 06/03/24.
//

import SwiftUI

@main
struct PocketMateApp: App {
    
    @StateObject private var dataController = DataModel.expensesdata
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
