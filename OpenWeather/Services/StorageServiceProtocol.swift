//
//  StorageServiceProtocol.swift
//  OpenWeatherApp
//
//  Created by Joel Ovienloba on 07/11/2025.
//

import Foundation

protocol StorageServiceProtocol {
	func saveFavoriteCity(_ city: String)
	func getFavoriteCity() -> String?
	func clearFavoriteCity()
}
