//
//  ViewController.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 3/1/22.
//

import UIKit

class CoinViewController: UIViewController {
    private var coinController: CoinController = CoinController()
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var coinPicker: UIPickerView!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        coinPicker.dataSource = self
        coinPicker.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinController.delegate = self
    }
}

// MARK: - UIPicker View Data and Delegate

extension CoinViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // How many columns there are in the picker.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // How many rows this picker should have.
        switch pickerView {
        case self.coinPicker:
            return self.coinController.coins.count
        case self.currencyPicker:
            return self.coinController.currencies.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        // Title for the given row.
        switch pickerView {
        case self.coinPicker:
            return self.coinController.coins[row]
        case self.currencyPicker:
            return self.coinController.currencies[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Set label to picked item.
        if pickerView == self.coinPicker {
            self.coinLabel.text = self.coinController.coins[row]
        } else if pickerView == self.currencyPicker {
            self.currencyLabel.text = self.coinController.currencies[row]
        }
        
        // Fetch price of selected items.
        let coin = self.coinLabel.text!
        let currency = self.currencyLabel.text!
        self.coinController.fetchPrice(for: coin, in: currency)
    }
}

// MARK: - Coin Controller Delegate

extension CoinViewController: CoinControllerDelegate {
    func didUpdateCoin(_ coin: Coin) {
        // Update UI.
        DispatchQueue.main.async {
            self.priceLabel.text = coin.rateFormat
            self.lastUpdateLabel.text = "Last update: \(coin.timeFormat)"
        }
    }

    func didFailWithError(_ error: Error) {
        print(error)
    }
}
