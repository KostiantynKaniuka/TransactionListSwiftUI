//
//  TansactionListViewModel.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import Foundation

final class TransactionListViewModel: ObservableObject {
    @Published var transactionCategory: Category = .all
    @Published var storedTransactions: [Item] = []
    @Published var filteredTransactions: [Item] = []
    @Published var isLoading: Bool = true
    @Published var isError: Bool = false
    
    init() {
        getTransaction()
    }
    
    //MARK: - Fetch transactions
    func getTransaction() {
        isLoading = true
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
            guard let self = self else { return }
            let shouldFailResponse = Int.random(in: 1...10) <= 5 // adjust failing 
            if shouldFailResponse {
                DispatchQueue.main.async {
                    print("❌ Failed to fetch transaction data.")
                    self.isLoading = false
                    self.isError = true
                }
            } else {
                guard let data = mockData.data(using: .utf8) else {
                    print("❌ Failed to convert mock data to UTF-8 encoding.")
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let result = try decoder.decode(Transactions.self, from: data)
                    
                    DispatchQueue.main.async {
                        self.storedTransactions = result.items
                        self.sortTransactions()
                        self.filterTransactions(for: self.transactionCategory)
                        self.isLoading = false
                        self.isError = false
                    }
                } catch {
                    print("✅ Error decoding mock data: \(error)")
                    DispatchQueue.main.async {
                        self.isError = true
                        self.isLoading = false
                    }
                }
            }
        }
    }
    
    //MARK: - Filter transactions
    func filterTransactions(for category: Category) {
        switch category {
        case .income:
            filteredTransactions = storedTransactions.filter { $0.category == 1 }
        case .domesticTransfer:
            filteredTransactions = storedTransactions.filter { $0.category == 2 }
        case .credit:
            filteredTransactions = storedTransactions.filter { $0.category == 3 }
        case .all:
            filteredTransactions = storedTransactions
        }
    }
    
    //MARK: - Total Amount
    func calculateTotalAmount(with categoty: Category) -> Decimal {
        switch categoty {
        case .income:
            return filteredTransactions.reduce(Decimal(0)) { $0 + Decimal($1.transactionDetail.value.amount) }
        case .domesticTransfer:
            return filteredTransactions.reduce(Decimal(0)) { $0 + Decimal($1.transactionDetail.value.amount) }
        case .credit:
            return filteredTransactions.reduce(Decimal(0)) { $0 + Decimal($1.transactionDetail.value.amount) }
        case .all:
            return 0
        }
    }
}

extension TransactionListViewModel {
    
    private func getDate(from dateString: String) -> Date { //is used for converting date  when sorting a list
        let dateFormatter = ISO8601DateFormatter()
        if let date = dateFormatter.date(from: dateString) {
            return date
        }
        return Date()
    }
    
    func sortTransactions() {
        let transactions = storedTransactions
        let sortedTransactions = transactions.sorted { (transaction1, transaction2) in
            let date1 = getDate(from: transaction1.transactionDetail.bookingDate)
            let date2 = getDate(from: transaction2.transactionDetail.bookingDate)
            return date1 > date2
        }
        storedTransactions = sortedTransactions
    }
    
}
