//
//  ContentView.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
                VStack(alignment: .leading, spacing: 24) {
                    Spacer(minLength: 50)
                    //MARK: - Title
                    
                    Text("Overview")
                        .padding(.leading)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.white)
                    //MARK: - Tramsaction list
                    TransactionList()
                        .background(Color.systemBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
                        .shadow(color: Color.icon, radius: 10, x: 0, y: 0)
                    
                }
                .padding(.top, 150)
                .edgesIgnoringSafeArea(.bottom)
                .frame(maxWidth: .infinity)
                .background(Color.background)
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    //MARK: - SortingButton
                    ToolbarItem(placement: .navigationBarTrailing) {
                        FilterButton()
                    }
                    //MARK: - TotalAmount
                    ToolbarItem(placement: .navigationBarLeading ) {
                        Text("Total Amount: 99999")
                            .font(.system(size: 16))
                            .bold()
                            .foregroundStyle(Color.white)
                    }
                }
        }
        .navigationViewStyle(.stack)
    }
}






struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TansactionListViewModel = {
        let transactionListVM = TansactionListViewModel()
        transactionListVM.transactions = transactionPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        ContentView()
            .environmentObject(transactionListVM)
    }
        
}
