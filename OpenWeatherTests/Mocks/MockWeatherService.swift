//
//  MockWeatherService.swift
//  WeatherAppTests
//
//  Mock implementation of WeatherServiceProtocol for testing
//

import Foundation
@testable import WeatherApp

class MockWeatherService: WeatherServiceProtocol {
    
    var shouldReturnError = false
    var errorToReturn: WeatherServiceError = .cityNotFound
    var weatherToReturn: Weather?
    var fetchWeatherCallCount = 0
    var lastSearchedCity: String?
    
    func fetchWeather(for city: String, completion: @escaping (Result<Weather, WeatherServiceError>) -> Void) {
        fetchWeatherCallCount += 1
        lastSearchedCity = city
        
        if shouldReturnError {
            completion(.failure(errorToReturn))
        } else if let weather = weatherToReturn {
            completion(.success(weather))
        } else {
            // Default mock weather data
            let mockWeather = Weather(
                cityName: city,
                temperature: 25.0,
                description: "Sunny",
                humidity: 60,
                windSpeed: 5.5
            )
            completion(.success(mockWeather))
        }
    }
}
