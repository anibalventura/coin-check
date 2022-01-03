//
//  ViewController.swift
//  CoinCheck
//
//  Created by Anibal Ventura on 3/1/22.
//

import UIKit

class CoinViewController: UIViewController {
    private let coinController: CoinController = CoinController()
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
    }
}

// MARK: - UIPicker View

extension CoinViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 // How many columns there are in the picker.
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        // How many rows this picker should have.
        return self.coinController.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.coinController.currencyArray[row] // Title for the given row.
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.currencyLabel.text = self.coinController.currencyArray[row]
    }
}
