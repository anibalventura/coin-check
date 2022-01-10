//
//  ViewController.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 3/1/22.
//

import UIKit

class CoinViewController: UIViewController {
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var coinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var lastUpdateLabel: UILabel!
    @IBOutlet weak var coinPicker: UIPickerView!
    @IBOutlet weak var currencyPicker: UIPickerView!

    private var coinController: CoinController = CoinController()

    override func viewDidLoad() {
        super.viewDidLoad()

        coinPicker.dataSource = self
        coinPicker.delegate = self
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinController.delegate = self

        loadDefaultViewValues()
        updateData()
    }

    @IBAction func refreshButtonPressed(_ sender: Any) {
        updateData()
    }

    private func loadDefaultViewValues() {
        priceLabel.text = Prefs.get(type: String.self, forKey: Consts.Prefs.price) ?? "$ 0.00"
        coinLabel.text = Prefs.get(type: String.self, forKey: Consts.Prefs.coin) ?? "BTC"
        currencyLabel.text = Prefs.get(type: String.self, forKey: Consts.Prefs.currency)  ?? "USD"
        lastUpdateLabel.text = Prefs.get(type: String.self, forKey: Consts.Prefs.lastUpdate)
                            ?? Localizable.lastUpdate("...")

        coinPicker.selectRow(
            coinController.coins.firstIndex(where: {$0 == self.coinLabel.text}) ?? 0,
            inComponent: 0,
            animated: true
        )
        currencyPicker.selectRow(
            coinController.currencies.firstIndex(where: {$0 == self.currencyLabel.text}) ?? 0,
            inComponent: 0,
            animated: true
        )
    }

    private func updateData() {
        coinController.fetchPrice(for: coinLabel.text!, in: currencyLabel.text!)
    }
}

// MARK: - UIPickerView Data Source

extension CoinViewController: UIPickerViewDataSource {
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
}

// MARK: - UIPickerView Delegate
extension CoinViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // Set label to picked item.
        if pickerView == self.coinPicker {
            self.coinLabel.text = self.coinController.coins[row]
        } else if pickerView == self.currencyPicker {
            self.currencyLabel.text = self.coinController.currencies[row]
        }

        let coin = self.coinLabel.text!
        let currency = self.currencyLabel.text!

        // Fetch price of selected items.
        self.coinController.fetchPrice(for: coin, in: currency)

        // Save selected items.
        Prefs.set(value: coin, key: Consts.Prefs.coin)
        Prefs.set(value: currency, key: Consts.Prefs.currency)
    }
}

// MARK: - Coin Controller Delegate

extension CoinViewController: CoinControllerDelegate {
    func didUpdateCoin(_ coin: Coin) {
        let price = coin.priceFormat
        let time = Localizable.lastUpdate("\(coin.timeFormat)")

        // Update UI.
        DispatchQueue.main.async {
            self.priceLabel.text = price
            self.lastUpdateLabel.text = time
        }

        // Save updated price.
        Prefs.set(value: price, key: Consts.Prefs.price)
        Prefs.set(value: time, key: Consts.Prefs.lastUpdate)
    }

    func didFailWithError(_ error: Error) {
        DispatchQueue.main.async {
            // Update UI.
            self.priceLabel.text = "$ 0.00"
            self.lastUpdateLabel.text = Localizable.lastUpdate("...")

            // Show error alert.
            let alert = UIAlertController(
                title: Localizable.alertTitle,
                message: Localizable.alertMessage(error.localizedDescription),
                preferredStyle: .alert
            )
            alert.addAction(
                UIAlertAction(title: Localizable.alertButton, style: .default)
            )
            self.present(alert, animated: true, completion: nil)
        }
    }
}
