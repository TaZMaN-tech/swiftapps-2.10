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
        ["EUR", "RUB", "GBP", "CNY"]
    }
    
    func getRate(_ currency: String) -> Double {
        switch currency {
        case "EUR":
            return rates.EUR
        case "RUB":
            return rates.RUB
        case "GBP":
            return rates.GBP
        default:
            return rates.CNY
        }
    }
}

struct ExchangeRates: Decodable {
    let EUR: Double
    let RUB: Double
    let GBP: Double
    let CNY: Double
}
