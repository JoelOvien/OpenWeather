//
//  MockStorageService.swift
//  WeatherAppTests
//
//  Mock implementation of StorageServiceProtocol for testing
//

import Foundation
@testable import WeatherApp

class MockStorageService: StorageServiceProtocol {
    
    var favoriteCity: String?
    var saveFavoriteCityCallCount = 0
    var getFavoriteCityCallCount = 0
    var clearFavoriteCityCallCount = 0
    
    func saveFavoriteCity(_ city: String) {
        saveFavoriteCityCallCount += 1
        favoriteCity = city
    }
    
    func getFavoriteCity() -> String? {
        getFavoriteCityCallCount += 1
        return favoriteCity
    }
    
    func clearFavoriteCity() {
        clearFavoriteCityCallCount += 1
        favoriteCity = nil
    }
}
