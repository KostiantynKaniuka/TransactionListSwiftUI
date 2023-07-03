//
//  ContentView.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State var filterSwitch: Category = .all
    @State private var showNetworkAlert = false
    
    var body: some View {
        NavigationView {
                VStack(alignment: .leading, spacing: 24) {
                    //Spacer(minLength: 50)
                    //MARK: - Title
                    Text("Overview")
                        .padding(.leading)
                        .font(.title2)
                        .bold()
                        .foregroundStyle(Color.systemBackground)
                    //MARK: - Tramsaction list
                    TransactionList(category: $filterSwitch)
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
                        FilterButton(filterSwitch: $filterSwitch)
                    }
                }
                .onAppear {
                                showNetworkAlert = !networkMonitor.isConnected
                            }
                .onChange(of: networkMonitor.isConnected) { connection in
                        showNetworkAlert = connection == false
                    }
                    .alert(
                        "Network connection seems to be offline.",
                        isPresented: $showNetworkAlert
                    ) {}
        }
        .navigationViewStyle(.stack)
    }
}

struct ContentView_Previews: PreviewProvider {
    static let transactionListVM: TransactionListViewModel = {
        let transactionListVM = TransactionListViewModel()
        transactionListVM.storedTransactions = transactionPreviewData
        return transactionListVM
    }()
    
    static var previews: some View {
        ContentView()
            .environmentObject(transactionListVM)
    }
}
