//
//  TransactionRow.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import SwiftUI

struct TransactionRow: View {
    var viewModel = TransactionRowViewModel()
    var transaction: Item
    
    var body: some View {
        HStack() {
            VStack(alignment: .leading, spacing: 6) {
                //MARK: -Transaction date
                Text(viewModel.formatDate(dateString: transaction.transactionDetail.bookingDate) ?? "")
                    .font(.system(size: 13))
                    .lineLimit(0)
                    .foregroundColor(.secondary)
                
                //MARK: -Transaction title
                Text(transaction.partnerDisplayName)
                    .font(.subheadline)
                    .bold()
                    .lineLimit(1)
                
                //MARK: -Transaction Description
                Text(transaction.transactionDetail.description ?? "")
                    .font(.subheadline)
                    .lineLimit(0)
            }
            Spacer()
            
            //MARK: -Transaktion amount
            Text(viewModel.formatCurrency(amout: transaction.transactionDetail.value.amount,
                                          withCurrencyCode: transaction.transactionDetail.value.currency) ?? "")
            .bold()
            .foregroundColor(viewModel.amountColor(_transaction: transaction.category))
            .font(.system(size: 14))
        }
        .padding([.top, .bottom], 8)
    }
}

struct TransactionRow_Previews: PreviewProvider {
    static var previews: some View {
        
        TransactionRow(transaction: transactionPreviewData[0])
    }
}
