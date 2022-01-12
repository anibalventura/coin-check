//
//  CoinController.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 3/1/22.
//

import Foundation
import Alamofire

protocol CoinControllerDelegate: AnyObject {
    func didUpdateCoin(_ coin: Coin)
    func didFailWithError(_ error: Error)
}

class CoinController {
    weak var delegate: CoinControllerDelegate?

    let coins: [String] = ["ADA", "AVAX", "BCH", "BNB", "BTC",
                           "DOGE", "DOT", "ETH", "LUNA", "LTC",
                           "SOL", "USDC", "USDT", "XRP"]
    let currencies: [String] = ["AUD", "BRL", "CAD", "CNY", "EUR",
                                "GBP", "HKD", "IDR", "ILS", "INR",
                                "JPY", "MXN", "NOK", "NZD", "PLN",
                                "RON", "RUB", "SEK", "SGD", "USD",
                                "ZAR"]

    func fetchPrice(for coin: String, in currency: String) {
        let url = "\(Consts.API.baseURL)/\(coin)/\(currency)?apikey=\(Consts.API.key)"

        AF.request(url).responseDecodable(of: CoinData.self) { response in
            switch response.result {
            case .success(let data):
                let coin = Coin(price: data.rate, time: data.time)
                self.delegate?.didUpdateCoin(coin)
            case .failure(let error):
                self.delegate?.didFailWithError(error)
            }
        }
    }
}
