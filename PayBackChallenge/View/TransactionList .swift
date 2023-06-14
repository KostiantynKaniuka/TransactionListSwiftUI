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
    @State private var totalAmount: Decimal = 0

    private var transactions: [Item] {
        transactionListVM.filteredTransactions
    }
 
    var body: some View {
        NavigationView {
            VStack {
                //MARK: - TotalAmount
                if totalAmount != 0 {
                                    Text("Total Amount: \(String(describing: totalAmount))")
                                        .font(.system(size: 16))
                                        .bold()
                                        .foregroundStyle(Color.black)
                                        .padding()
                                }
                
                //MARK: - LIST
                List {
                    ForEach(transactions.indices, id: \.self) { index in
                        NavigationLink {
                            TransactionDetails(transaction: transactions[index])
                        } label: {
                            TransactionRow(transaction: transactions[index])
                        }
                    }
                }
                .id(UUID())
                .onChange(of: category, perform: { newValue in
                    transactionListVM.filterTransactions(for: category)
                    totalAmount = transactionListVM.calculateTotalAmount(with: category)
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
