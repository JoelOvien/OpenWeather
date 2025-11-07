//
//  HomeViewModelTests.swift
//  WeatherAppTests
//
//  Unit tests for HomeViewModel
//

import XCTest
@testable import WeatherApp

class HomeViewModelTests: XCTestCase {
    
    var sut: HomeViewModel!
    var mockWeatherService: MockWeatherService!
    var mockStorageService: MockStorageService!
    
    override func setUp() {
        super.setUp()
        mockWeatherService = MockWeatherService()
        mockStorageService = MockStorageService()
        sut = HomeViewModel(
            weatherService: mockWeatherService,
            storageService: mockStorageService
        )
    }
    
    override func tearDown() {
        sut = nil
        mockWeatherService = nil
        mockStorageService = nil
        super.tearDown()
    }
    
    // MARK: - Tests for viewDidLoad
    
    func testViewDidLoad_LoadsFavoriteCity() {
        // Given
        mockStorageService.favoriteCity = "London"
        let expectation = XCTestExpectation(description: "Favorite city loaded")
        
        sut.onFavoriteCityLoaded = { city in
            XCTAssertEqual(city, "London")
            expectation.fulfill()
        }
        
        // When
        sut.viewDidLoad()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockStorageService.getFavoriteCityCallCount, 1)
    }
    
    func testViewDidLoad_NoFavoriteCity_DoesNotLoadCity() {
        // Given
        mockStorageService.favoriteCity = nil
        var cityLoaded = false
        
        sut.onFavoriteCityLoaded = { _ in
            cityLoaded = true
        }
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertFalse(cityLoaded)
        XCTAssertEqual(mockStorageService.getFavoriteCityCallCount, 1)
    }
    
    // MARK: - Tests for searchWeather
    
    func testSearchWeather_WithValidCity_FetchesWeatherSuccessfully() {
        // Given
        sut.cityName = "Paris"
        let expectation = XCTestExpectation(description: "Weather fetched")
        
        sut.onWeatherFetched = { weather in
            XCTAssertEqual(weather.cityName, "Paris")
            expectation.fulfill()
        }
        
        // When
        sut.searchWeather()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockWeatherService.fetchWeatherCallCount, 1)
        XCTAssertEqual(mockWeatherService.lastSearchedCity, "Paris")
    }
    
    func testSearchWeather_WithEmptyCity_ShowsError() {
        // Given
        sut.cityName = ""
        let expectation = XCTestExpectation(description: "Error shown")
        
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, "Please enter a city name")
            expectation.fulfill()
        }
        
        // When
        sut.searchWeather()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockWeatherService.fetchWeatherCallCount, 0)
    }
    
    func testSearchWeather_WithWhitespaceCity_ShowsError() {
        // Given
        sut.cityName = "   "
        let expectation = XCTestExpectation(description: "Error shown")
        
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, "Please enter a city name")
            expectation.fulfill()
        }
        
        // When
        sut.searchWeather()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(mockWeatherService.fetchWeatherCallCount, 0)
    }
    
    func testSearchWeather_ServiceReturnsError_ShowsErrorMessage() {
        // Given
        sut.cityName = "InvalidCity"
        mockWeatherService.shouldReturnError = true
        mockWeatherService.errorToReturn = .cityNotFound
        let expectation = XCTestExpectation(description: "Error shown")
        
        sut.onError = { errorMessage in
            XCTAssertEqual(errorMessage, WeatherServiceError.cityNotFound.localizedDescription)
            expectation.fulfill()
        }
        
        // When
        sut.searchWeather()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchWeather_UpdatesLoadingState() {
        // Given
        sut.cityName = "Tokyo"
        var loadingStates: [Bool] = []
        
        sut.onLoadingStateChanged = { isLoading in
            loadingStates.append(isLoading)
        }
        
        let expectation = XCTestExpectation(description: "Loading states updated")
        sut.onWeatherFetched = { _ in
            expectation.fulfill()
        }
        
        // When
        sut.searchWeather()
        
        // Then
        wait(for: [expectation], timeout: 1.0)
        XCTAssertEqual(loadingStates, [true, false])
    }
    
    // MARK: - Tests for saveFavoriteCity
    
    func testSaveFavoriteCity_WithValidCity_SavesSuccessfully() {
        // Given
        sut.cityName = "Berlin"
        
        // When
        sut.saveFavoriteCity()
        
        // Then
        XCTAssertEqual(mockStorageService.saveFavoriteCityCallCount, 1)
        XCTAssertEqual(mockStorageService.favoriteCity, "Berlin")
    }
    
    func testSaveFavoriteCity_WithEmptyCity_DoesNotSave() {
        // Given
        sut.cityName = ""
        
        // When
        sut.saveFavoriteCity()
        
        // Then
        XCTAssertEqual(mockStorageService.saveFavoriteCityCallCount, 0)
    }
    
    func testSaveFavoriteCity_TrimsWhitespace() {
        // Given
        sut.cityName = "  Rome  "
        
        // When
        sut.saveFavoriteCity()
        
        // Then
        XCTAssertEqual(mockStorageService.favoriteCity, "Rome")
    }
    
    // MARK: - Tests for clearFavoriteCity
    
    func testClearFavoriteCity_ClearsStorageAndCityName() {
        // Given
        sut.cityName = "Madrid"
        mockStorageService.favoriteCity = "Madrid"
        
        // When
        sut.clearFavoriteCity()
        
        // Then
        XCTAssertEqual(mockStorageService.clearFavoriteCityCallCount, 1)
        XCTAssertEqual(sut.cityName, "")
    }
}
