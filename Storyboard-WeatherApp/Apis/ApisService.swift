//
//  ApisService.swift
//  Storyboard-WeatherApp
//
//  Created by Joseph on 5/10/23.
//

import Foundation


struct WeatherApiServiceManager{
    
    func getCurrentWeather(cityName: String) async throws -> WeatherModel? {
        
        print(cityName)
        
        let endpoint = "\(ApiConstants.currentWeatherUrl)&q=\(cityName)"
        
        guard let url = URL(string: endpoint) else {
            throw WeatherError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw WeatherError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            let decodedResponse = try decoder.decode(CurrentWeatherModel.self, from: data)
            
           let weather = WeatherModel(conditionId: decodedResponse.weather[0].id, cityName: decodedResponse.name, temperature: decodedResponse.main.temp)
            
            return weather
        } catch{
            throw WeatherError.invalidURL
        }
    
    }
}
