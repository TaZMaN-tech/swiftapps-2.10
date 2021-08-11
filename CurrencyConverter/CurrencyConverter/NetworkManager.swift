//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by Тадевос Курдоглян on 12.08.2021.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchExchange(complition: @escaping (Exchange) -> Void) {
        AF.request("https://openexchangerates.org/api/latest.json?app_id=caf02b30e07d432c9ca85141f941bed3", method: .get)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    guard let exchange = value as? [String: Any] else { return }
                    guard let rates = exchange["rates"] as? [String: Any] else { return }
                    let exchangeRates = ExchangeRates(
                        EUR: rates["EUR"] as? Double ?? 0,
                        RUB: rates["RUB"] as? Double ?? 0,
                        GBP: rates["GBP"] as? Double ?? 0,
                        CNY: rates["CNY"] as? Double ?? 0
                    )
                    complition(Exchange(base: exchange["base"] as? String ?? "", rates: exchangeRates))
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    
    
}
