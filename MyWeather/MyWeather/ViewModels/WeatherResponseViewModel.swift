//
//  WeatherResponseVievModel.swift
//  MyWeather
//
//  Created by HAKAN on 30.11.2024.
//

import Foundation

struct WeatherResponseViewModel: Decodable {
    let cityName: String
    let temperature: Double
    let condition: String
    let humidity: Int
    let windSpeed: Double
    let pressure: Double
    let icon: String
    
    var temperatureFormatted: String {
        return String(format: "%.1f°C", temperature)
    }
    
    init(from response: WeatherResponse) {
        self.cityName = response.location.name
        self.temperature = response.current.tempC
        self.condition = response.current.condition.text
        self.humidity = response.current.humidity
        self.windSpeed = response.current.windKph
        self.icon = response.current.condition.icon
        self.pressure = response.current.pressure_mb
    }
}

