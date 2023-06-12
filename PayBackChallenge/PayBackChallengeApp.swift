//
//  PayBackChallengeApp.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import SwiftUI

@main
struct PayBackChallengeApp: App {
    var body: some Scene {
        WindowGroup {
            TransactionRow(transaction: transactionPreviewData.items[0])
        }
    }
}