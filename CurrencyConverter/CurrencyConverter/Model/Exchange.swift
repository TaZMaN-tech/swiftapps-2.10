//
//  Exchange.swift
//  CurrencyConverter
//
//  Created by Тадевос Курдоглян on 07.08.2021.
//

import Foundation

struct Exchange: Decodable {
    let base: String
    let rates: ExchangeRates
}

struct ExchangeRates: Decodable {
    let EUR: Double
    let RUB: Double
    let GBP: Double
    let CNY: Double
}
