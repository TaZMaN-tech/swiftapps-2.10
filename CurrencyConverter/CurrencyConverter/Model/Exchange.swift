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
    
    func gerCurrencies() -> [String] {
        Mirror(reflecting: rates).children.map {$0.label ?? ""}
    }
    
    func getRate(_ currency: String) -> Double {
        guard let value = Mirror(reflecting: rates).children.filter({$0.label == currency})[0].value as? Double else {
            return 0
        }
        return value
    }
}

struct ExchangeRates: Decodable {
    let EUR: Double
    let RUB: Double
    let GBP: Double
    let CNY: Double
}
