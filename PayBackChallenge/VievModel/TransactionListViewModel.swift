//
//  TansactionListViewModel.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import Foundation
import Combine


final class TransactionListViewModel: ObservableObject {
    
    @Published var transactionCategory: Category = .income
    @Published var storedTransactions: [Item] = []
    
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
            }
            .store(in: &cancellables)
    }
}
    
    extension TransactionListViewModel {
        
        private func getDate(from dateString: String) -> Date { //is used for sorting when representing a list
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
