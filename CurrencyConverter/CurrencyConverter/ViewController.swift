//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Тадевос Курдоглян on 07.08.2021.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var sourceAmountTextField: UITextField!
    @IBOutlet weak var destAmountTextField: UITextField!
    @IBOutlet weak var destAmountLabel: UILabel!
    
    let currencies = ["EUR",
                      "RUB",
                      "GBP",
                      "CNY"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        updateDestAmountLabel(0)
    }
    private func updateDestAmountLabel(_ row: Int) {
        destAmountLabel.text = "\(currencies[row]) amount:"
    }

}

extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencies.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currencies[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        updateDestAmountLabel(row)
    }
    
}
