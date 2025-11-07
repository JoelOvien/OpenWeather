//
//  WeatherApiService.swift
//  OpenWeatherApp
//
//  Created by Joel Ovienloba on 07/11/2025.
//


import Foundation

public class WeatherAPIService: WeatherServiceProtocol {
	
	private let apiKey = "API_KEY"
	private let baseURL = "https://api.openweathermap.org/data/2.5/weather"
	private let session: URLSession
	
	public init(session: URLSession = .shared) {
		self.session = session
	}
	
	public func fetchWeather(for city: String, completion: @escaping (Result<Weather, WeatherServiceError>) -> Void) {
		// Construct URL with query parameters
		guard var urlComponents = URLComponents(string: baseURL) else {
			completion(.failure(.invalidURL))
			return
		}
		
		urlComponents.queryItems = [
			URLQueryItem(name: "q", value: city),
			URLQueryItem(name: "appid", value: apiKey),
			URLQueryItem(name: "units", value: "metric")
		]
		
		guard let url = urlComponents.url else {
			completion(.failure(.invalidURL))
			return
		}
		
		// Make API request
		let task = session.dataTask(with: url) { data, response, error in
			// Handle network error
			if let error = error {
				completion(.failure(.networkError(error)))
				return
			}
			
			// Validate HTTP response
			guard let httpResponse = response as? HTTPURLResponse else {
				completion(.failure(.invalidResponse))
				return
			}
			
			// Check for city not found (404)
			if httpResponse.statusCode == 404 {
				completion(.failure(.cityNotFound))
				return
			}
			
			// Validate success status code
			guard (200...299).contains(httpResponse.statusCode) else {
				completion(.failure(.invalidResponse))
				return
			}
			
			// Validate data exists
			guard let data = data else {
				completion(.failure(.invalidResponse))
				return
			}
			
			// Decode JSON response
			do {
				let decoder = JSONDecoder()
				let weatherResponse = try decoder.decode(WeatherResponse.self, from: data)
				let weather = weatherResponse.toDomain()
				completion(.success(weather))
			} catch {
				completion(.failure(.decodingError(error)))
			}
		}
		
		task.resume()
	}
}
