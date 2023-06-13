//
//  PreviewData.swift
//  PayBackChallenge
//
//  Created by Kostiantyn Kaniuka on 12.06.2023.
//

import Foundation

var transactionPreviewData =  [
    Item(
        partnerDisplayName: "REWE Group",
        alias: Alias(reference: "795357452000810"),
        category: 5,
        transactionDetail: TransactionDetail(
            description: "Punkte sammeln",
            bookingDate: "2022-07-24T10:59:05+0200",
            value: Value(amount: 124.01, currency: "USD")
        )
    ),
    Item(
        partnerDisplayName: "dm-dogerie markt",
        alias: Alias(reference: "098193809705561"),
        category: 2,
        transactionDetail: TransactionDetail(
            description: "Punkte sammeln",
            bookingDate: "2022-06-23T10:59:05+0200",
            value: Value(amount: 1240, currency: "PBP")
        )
    ),
    Item(
        partnerDisplayName: "REWE Group",
        alias: Alias(reference: "795357452000810"),
        category: 1,
        transactionDetail: TransactionDetail(
            description: "Punkte sammeln",
            bookingDate: "2022-07-24T10:59:05+0200",
            value: Value(amount: 124, currency: "PBP")
        )
    ),
    Item(
        partnerDisplayName: "REWE Group",
        alias: Alias(reference: "795357452000810"),
        category: 3,
        transactionDetail: TransactionDetail(
            description: "Punkte sammeln",
            bookingDate: "2022-07-24T10:59:05+0200",
            value: Value(amount: 124, currency: "PBP")
        )
    ),
    Item(
        partnerDisplayName: "dm-dogerie markt",
        alias: Alias(reference: "098193809705561"),
        category: 2,
        transactionDetail: TransactionDetail(
            description: "Punkte sammeln",
            bookingDate: "2022-06-23T10:59:05+0200",
            value: Value(amount: 1240, currency: "PBP")
        )
    )
]
