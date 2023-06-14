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
    @State private var showAlert: Bool = false
    
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
                if transactionListVM.isLoading { // Show progress view when loading
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .scaleEffect(1.5)
                } else {
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
        //MARK: - Server Alert
        .alert(isPresented: $transactionListVM.isError, content: {
            Alert(
                title: Text("Error"),
                message: Text("Failed to fetch transaction data."),
                primaryButton: .default(Text("Refresh"), action: {
                    transactionListVM.getTransaction()
                }),
                secondaryButton: .cancel(Text("OK"))
            )
        })
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
