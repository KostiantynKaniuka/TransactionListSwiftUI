//
//  TansactionListViewModel.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import Foundation
import Combine


final class TransactionListViewModel: ObservableObject {
    @Published var transactionCategory: Category = .all
    @Published var storedTransactions: [Item] = []
    @Published var filteredTransactions: [Item] = []
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        getTransaction()
    }
    
    func getTransaction() {
        guard let data = mockData.data(using: .utf8) else {
            print("❌ Failed to convert mock data to UTF-8 encoding.")
            return
        }
        let decoder = JSONDecoder()
        Just(data)
            .decode(type: Transactions.self, decoder: decoder)
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("✅ Error decoding mock data: \(error)")
                }
            } receiveValue: { [weak self] result in
                self?.storedTransactions = result.items
                self?.sortTransactions()
                self?.filterTransactions(for: self?.transactionCategory ?? .income)
            }
            .store(in: &cancellables)
    }
    
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
