//
//  TransactionDetails.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 13.06.2023.
//

import SwiftUI

struct TransactionDetails: View {
    let transaction: Item
    var body: some View {
        ZStack {
            HStack {
                Text(transaction.partnerDisplayName)
                    .bold()
                    .foregroundColor(.white)
                Text(transaction.transactionDetail.description ?? "")
                    .foregroundColor(.white)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.background)
    }
}

struct TransactionDetails_Previews: PreviewProvider {
    static var previews: some View {
        TransactionDetails(transaction: transactionPreviewData.items[0])
    }
}
