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
        VStack {
            if let transactions = transactionListVM.transactions?.items {
                //MARK: -Sorting from newest to oldes
                let sortedTransactions = transactions.sorted { (transaction1, transaction2) in
                    let date1 = transactionListVM.getDate(from: transaction1.transactionDetail.bookingDate)
                    let date2 = transactionListVM.getDate(from: transaction2.transactionDetail.bookingDate)
                              return date1 > date2
                          }
                List {
                    ForEach(sortedTransactions.indices, id: \.self) { index in
                        TransactionRow(transaction: sortedTransactions[index])
                    }
                }
            }
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
