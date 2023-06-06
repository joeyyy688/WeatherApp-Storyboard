// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let currentWeatherModel = try? JSONDecoder().decode(CurrentWeatherModel.self, from: jsonData)

import Foundation

// MARK: - CurrentWeatherModel
struct CurrentWeatherModel: Codable {
    let weather: [Weather]
    let main: Main
    let visibility: Int
    let dt: Int
    let timezone, id: Int
    let name: String
    let cod: Int
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike
        case tempMin
        case tempMax
        case pressure, humidity
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, description, icon: String
}

