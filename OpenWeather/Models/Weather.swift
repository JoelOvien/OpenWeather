//
//  Weather.swift
//  OpenWeatherApp
//
//  Created by Joel Ovienloba on 07/11/2025.
//


import Foundation

public struct Weather {
	public let cityName: String
	public let temperature: Double
	public let description: String
	public let humidity: Int
	public let windSpeed: Double
	
	public init(cityName: String, temperature: Double, description: String, humidity: Int, windSpeed: Double) {
		self.cityName = cityName
		self.temperature = temperature
		self.description = description
		self.humidity = humidity
		self.windSpeed = windSpeed
	}
	
	// Computed property for formatted temperature
	public var temperatureString: String {
		return String(format: "%.1f°C", temperature)
	}
	
	// Computed property for formatted wind speed
	public var windSpeedString: String {
		return String(format: "%.1f m/s", windSpeed)
	}
}
