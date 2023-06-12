//
//  PayBackChallengeApp.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import SwiftUI

@main
struct PayBackChallengeApp: App {
    @StateObject var transactionListVM = TansactionListViewModel()
    
    var body: some Scene {
        WindowGroup {
            TransactionRow(transaction: transactionPreviewData.items[0])
                .environmentObject(transactionListVM)
        }
    }
}
