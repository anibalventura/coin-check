//
//  Constants.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 10/1/22.
//

import Foundation

struct Consts {
    struct Prefs {
        static let price: String = "PriceKey"
        static let coin: String = "CoinKey"
        static let currency: String = "CurrencyKey"
        static let lastUpdate: String = "LastUpdateKey"
    }

    struct API {
        static let baseURL: String = "https://rest.coinapi.io/v1/exchangerate"
        static let key: String = "YOUR_API_KEY_HERE"
    }
}
