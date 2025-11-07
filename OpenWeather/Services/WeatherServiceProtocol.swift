//
//  WeatherServiceProtocol.swift
//  OpenWeatherApp
//
//  Created by Joel Ovienloba on 07/11/2025.
//


import Foundation

public enum WeatherServiceError: Error {
	case invalidURL
	case networkError(Error)
	case invalidResponse
	case decodingError(Error)
	case cityNotFound
	
	public var localizedDescription: String {
		switch self {
		case .invalidURL:
			return "Invalid URL"
		case .networkError(let error):
			return "Network error: \(error.localizedDescription)"
		case .invalidResponse:
			return "Invalid response from server"
		case .decodingError(let error):
			return "Failed to decode response: \(error.localizedDescription)"
		case .cityNotFound:
			return "City not found. Please check the spelling and try again."
		}
	}
}

public protocol WeatherServiceProtocol {
	func fetchWeather(for city: String, completion: @escaping (Result<Weather, WeatherServiceError>) -> Void)
}
