//
//  TansactionListViewModel.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import Foundation
import Combine

final class TansactionListViewModel: ObservableObject {
    @Published var transactions: [Transactions] = []
    
    func getTransaction() {
        guard let url = URL(string: "https://api-test.payback.com/transactions") else {
            print("❌ invalid url")
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .tryMap { (data, responce) -> Data in
                guard let httpResponce = responce as? HTTPURLResponse, httpResponce.statusCode == 200 else {
                    dump(responce)
                    throw URLError (.badServerResponse)
                }
                return data
            }
            .decode(type: [Transactions].self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .failure(let error):
                    print("Error fetching transactions", error.localizedDescription)
                case .finished:
                    print("✅ Finished Fetching transaction")
                }
            } receiveValue: { result in
                self.transactions = result 
            }

            
    }
}
