//
//  TransactionList.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import SwiftUI

struct TransactionList: View {
    @EnvironmentObject var transactionListVM: TransactionListViewModel
    @Binding var category: Category
    @State private var filteredTransaction: [Item] = []
    private var transactions: [Item] {
        filteredTransaction.isEmpty ? transactionListVM.storedTransactions: filteredTransaction
    }
    
    private func performFiltering() {
        switch category {
        case .income:
            filteredTransaction = transactionListVM.storedTransactions.filter{$0.category == 1}
        case .domesticTransfer:
            filteredTransaction = transactionListVM.storedTransactions.filter{$0.category == 2}
        case .credit:
            filteredTransaction = transactionListVM.storedTransactions.filter{$0.category == 3}
        case .all:
            filteredTransaction = transactionListVM.storedTransactions
        }
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(transactions.indices, id: \.self) { index in
                        NavigationLink {
                            TransactionDetails(transaction: transactions[index])
                        } label: {
                            TransactionRow(transaction: transactions[index])
                        }
                    }
                }
                .onChange(of: category, perform: { newValue in
                    performFiltering()
                })
            }
        }
    }
}


struct TransactionList__Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
    transactionListVM.storedTransactions = transactionPreviewData
        return transactionListVM
    }()
    static var previews: some View {
        TransactionList( category: .constant(.all))
            .environmentObject(transactionListVM)
    }
}
