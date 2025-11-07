//
//  WeatherDetailviewmodel.swift
//  OpenWeatherApp
//
//  Created by Joel Ovienloba on 07/11/2025.
//


import Foundation

class WeatherDetailViewModel {
	
	// MARK: - Properties
	private let weather: Weather
	
	// MARK: - Initialization
	init(weather: Weather) {
		self.weather = weather
	}
	
	// MARK: - Computed Properties for View
	
	var cityName: String {
		return weather.cityName
	}
	
	var temperature: String {
		return weather.temperatureString
	}
	
	var description: String {
		return weather.description
	}
	
	var humidity: String {
		return "\(weather.humidity)%"
	}
	
	var windSpeed: String {
		return weather.windSpeedString
	}
	
	var displayTitle: String {
		return "Weather in \(weather.cityName)"
	}
}
