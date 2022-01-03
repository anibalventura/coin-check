//
//  CoinController.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 3/1/22.
//

import Foundation

protocol CoinControllerDelegate {
    func didUpdateCoin(_ coin: Coin)
    func didFailWithError(_ error: Error)
}

class CoinController {
    private let networkManager: NetworkManager = NetworkManager()
    var delegate: CoinControllerDelegate?
    let currencyArray = ["AUD", "BRL", "CAD", "CNY", "EUR", "GBP", "HKD", "IDR", "ILS", "INR", "JPY", "MXN", "NOK", "NZD", "PLN", "RON", "RUB", "SEK", "SGD", "USD", "ZAR"]
    
    func fetchBitCoinPrice(for currency: String) {
        let url = "\(CoinAPI.baseURL)/BTC/\(currency)?apikey=\(CoinAPI.key)"
        getCoinPrice(from: url)
    }
    
    private func getCoinPrice(from url: String) {
        networkManager.fetchData(from: url) { (result: Result<CoinData,Error>) in
            switch result {
            case .success(let model):
                let coin = Coin(rate: model.rate, time: model.time)
                self.delegate?.didUpdateCoin(coin)
            case .failure(let error):
                self.delegate?.didFailWithError(error)
            }
        }
    }
}
