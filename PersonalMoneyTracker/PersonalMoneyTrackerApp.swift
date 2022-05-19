//
//  PersonalMoneyTrackerApp.swift
//  PersonalMoneyTracker
//
//  Created by Şeyda Şeyma Balcı on 14.05.2022.
//

import SwiftUI

@main
struct PersonalMoneyTrackerApp: App {
  @StateObject  var transactionListVM = TransactionListViewModel()
    
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(transactionListVM)
        }
    }
}
