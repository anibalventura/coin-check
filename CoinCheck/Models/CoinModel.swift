//
//  CoinModel.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 3/1/22.
//

import Foundation

struct Coin {
    let rate: Double
    
    var rateFormat: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: NSNumber(value:self.rate))!
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
