//
//  CoinModel.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 3/1/22.
//

import Foundation

struct Coin {
    let rate: Double
    let time: String
    
    var rateFormat: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        numberFormatter.currencySymbol = "$"
        return numberFormatter.string(from: NSNumber(value:self.rate))!
    }
    
    var timeFormat: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        return dateFormatter.date(from: self.time) ?? Date.now
    }
}

// MARK: - Coin Data
struct CoinData: Codable {
    let time, assetIDBase, assetIDQuote: String
    let rate: Double
    
    enum CodingKeys: String, CodingKey {
        case time
        case assetIDBase = "asset_id_base"
        case assetIDQuote = "asset_id_quote"
        case rate
    }
}
