//
//  TransactionModel.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import Foundation

struct Transactions: Codable {
    let items: [Item]
}

struct Item: Codable {
    let partnerDisplayName: String
    let alias: Alias
    let category: Int
    let transactionDetail: TransactionDetail
}

struct Alias: Codable {
    let reference: String
}

struct TransactionDetail: Codable {
    let description: String
    let bookingDate: String
    let value: Value
}

struct Value: Codable {
    let amount: Double
    let currency: String
}


enum Category {
    case income
    case domesticTransfer
    case credit
    case error
    
    init(rawValue: Int) {
        switch rawValue {
        case 1:
            self = .income
        case 2:
            self = .domesticTransfer
        case 3:
            self = .credit
        default:
            self = .error
        }
    }
    
    var description: String {
        switch self {
        case .income:
            return "Income"
        case .domesticTransfer:
            return "Debit"
        case .credit:
            return "Credit"
        case .error:
            return "Please try again later"
        }
    }
}
