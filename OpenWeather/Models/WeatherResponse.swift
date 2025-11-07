//
//  WeatherResponse.swift
//  OpenWeatherApp
//
//  Created by Joel Ovienloba on 07/11/2025.
//

import Foundation

struct WeatherResponse: Codable {
	let name: String
	let main: Main
	let weather: [WeatherDescription]
	let wind: Wind
	
	struct Main: Codable {
		let temp: Double
		let humidity: Int
	}
	
	struct WeatherDescription: Codable {
		let description: String
	}
	
	struct Wind: Codable {
		let speed: Double
	}
	
	// Convert API response to domain model
	func toDomain() -> Weather {
		return Weather(
			cityName: name,
			temperature: main.temp,
			description: weather.first?.description.capitalized ?? "No description",
			humidity: main.humidity,
			windSpeed: wind.speed
		)
	}
}
