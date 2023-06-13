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
//    var id: Int {
//        return Int(alias.reference)!
//    }
    
//    private enum CodingKeys: String, CodingKey {
//        case alias
//        case partnerDisplayName
//        case category
//        case transactionDetail
//    }
}

struct Alias: Codable {
    let reference: String
}

struct TransactionDetail: Codable {
    let description: String?
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
    case all
    
    init(rawValue: Int) {
        switch rawValue {
        case 1:
            self = .income
        case 2:
            self = .domesticTransfer
        case 3:
            self = .credit
        default:
            self = .all
        }
    }
}
