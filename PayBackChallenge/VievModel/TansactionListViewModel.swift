//
//  TansactionListViewModel.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import Foundation
import Combine

final class TansactionListViewModel: ObservableObject {
    @Published var transactions: Transactions?
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
                self?.transactions = result
            }
            .store(in: &cancellables)
    }
}
