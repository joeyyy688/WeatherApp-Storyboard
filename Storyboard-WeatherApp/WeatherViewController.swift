//
//  ViewController.swift
//  Storyboard-WeatherApp
//
//  Created by Joseph on 5/9/23.
//

import UIKit

class WeatherViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var conditionImageView: UIImageView!
    @IBOutlet var temperatureLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    @IBOutlet var searchTextField: UITextField!
    
    var weatherApiServiceManager = WeatherApiServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        searchTextField.delegate = self
        
    }
    
    
    @IBAction func searchButtonPressed(_ sender: UIButton) {
        Task {
            print("executed function")
            await onSearchComplete()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        Task {
            print("executed function")
            await onSearchComplete()
        }
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        Task {
            print("executed function")
            await onSearchComplete()
        }
        searchTextField.text = ""
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if textField.text == "" {
            return true
        }else {
            textField.placeholder = "Type something to search"
            return false
        }
    }
    
    func onSearchComplete() async {
        if let safeTextfieldString = searchTextField.text {
            let weatherData = try? await weatherApiServiceManager.getCurrentWeather(cityName: safeTextfieldString.trimmingCharacters(in: .whitespaces))
            
            print(weatherData ?? "test")
            
            
            DispatchQueue.main.async {
                self.temperatureLabel.text = weatherData?.temperatureString
                self.cityLabel.text = weatherData?.cityName
                self.conditionImageView.image = UIImage(systemName: weatherData!.conditionName)
            }
        }
        searchTextField.endEditing(true)
    }
    

}

