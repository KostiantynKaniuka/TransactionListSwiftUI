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
                List {
                    ForEach(transactionListVM.filterTransactions().indices, id: \.self) { index in
                        NavigationLink {
                            TransactionDetails(transaction: transactionListVM.filterTransactions()[index])
                        } label: {
                            TransactionRow(transaction: transactionListVM.filterTransactions()[index])
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
