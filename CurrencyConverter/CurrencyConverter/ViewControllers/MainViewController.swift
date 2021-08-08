//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Тадевос Курдоглян on 07.08.2021.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var sourceAmountTextField: UITextField!
    @IBOutlet weak var destAmountTextField: UITextField!
    @IBOutlet weak var destAmountLabel: UILabel!
    
    private var currencies: [String] = []
    private var exchange: Exchange!
    private var lastDirection: Direction = .srcToDest
    
    enum Direction {
        case srcToDest
        case destToSrc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        getCurrencies()
        hideKeyboardWhenTappedAround()
    }
    private func updateDestAmountLabel(_ row: Int) {
        destAmountLabel.text = "\(currencies[row]) amount:"
    }
    
    private func getCurrencies() {
        guard let url = URL(string: "https://openexchangerates.org/api/latest.json?app_id=caf02b30e07d432c9ca85141f941bed3") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error discription")
                return
            }
            print(response)
            do {
                self.exchange = try JSONDecoder().decode(Exchange.self , from: data)
                self.currencies = self.exchange.gerCurrencies()
                DispatchQueue.main.async {
                    self.currencyPicker.reloadAllComponents()
                    self.updateDestAmountLabel(0)
                }
            } catch let error {
                print(error.localizedDescription)
            }
            
        } .resume()
    }
    
    private func updateAmounts(_ direction: Direction) {
        let fromTextField: UITextField!
        let toTextField: UITextField!
        let rate = exchange.getRate(currencies[currencyPicker.selectedRow(inComponent: 0)])
        
        if direction == .srcToDest {
            fromTextField = sourceAmountTextField
            toTextField = destAmountTextField
        } else {
            fromTextField = destAmountTextField
            toTextField = sourceAmountTextField
        }

        guard let text = fromTextField.text else { return }
        if let currentValue = Double(text) {
            toTextField.text = String(format: "%.2f", direction == .srcToDest ? currentValue * rate : currentValue / rate)
        }
    }
    
    @IBAction func sourceAmountEditingChanged() {
        updateAmounts(.srcToDest)
        lastDirection = .srcToDest
    }
    @IBAction func destAmountEditingChanged() {
        updateAmounts(.destToSrc)
        lastDirection = .destToSrc
    }
}

extension MainViewController: UIPickerViewDelegate, UIPickerViewDataSource {
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
        updateAmounts(lastDirection)
    }
}

extension MainViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(MainViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}