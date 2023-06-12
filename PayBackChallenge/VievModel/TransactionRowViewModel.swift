//
//  TransactionRowViewModel.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import SwiftUI

struct TransactionRowViewModel {
    
    func formatDate(dateString: String) -> String? { // I make it optional in case the date format from server is invalid
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale.current
        guard let date = dateFormatter.date(from: dateString) else {
            return ""
        }
        dateFormatter.dateFormat = "dd MMMM, yyyy, HH:mm:ss"
        let formattedDate = dateFormatter.string(from: date)
        return formattedDate
    }
    
    func formatCurrency(amout: Double, withCurrencyCode currencyCode: String) -> String? {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.usesGroupingSeparator = true
        formatter.currencyCode = currencyCode
        let decimalValue = Decimal(amout)
        if let result = formatter.string(from: decimalValue as NSNumber) {
            return result
        }
        
        return ""
        
    }
    
    func amountColor(_transaction categoty: Int) -> Color {
        let colorSwitch: Category = .init(rawValue: categoty)
        switch colorSwitch {
        case .income:
            return .green
        case .domesticTransfer:
            return .blue
        case .credit:
            return .red
        case .error:
            return .gray
        }
    }
    
}
