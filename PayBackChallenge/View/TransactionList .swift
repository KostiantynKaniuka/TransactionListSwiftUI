//
//  TransactionList.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM: TansactionListViewModel
    
    var body: some View {
            if let transactions = transactionListVM.transactions?.items {
                List {
                    
                    ForEach(transactions) { transaction in
                        TransactionRow(transaction: transaction)
                    }
                    .background(Color.systemBackground)
                }
                .padding()
                
                .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                .shadow(color: .primary.opacity(0.2), radius: 10, x: 0, y: 5)
            }
    }
}

struct TransactionList__Previews: PreviewProvider {
    static let transactionListVM: TansactionListViewModel = {
        let transactionListVM = TansactionListViewModel()
        transactionListVM.transactions = transactionPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        TransactionList()
            .environmentObject(transactionListVM)
    }
}
