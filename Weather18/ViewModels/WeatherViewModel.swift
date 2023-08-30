//
//  WeatherViewModel.swift
//  Weather18
//
//  Created by Prabhakar Patil on 30/08/23.
//

import Foundation

@MainActor
class WeatherViewModel: ObservableObject {
    
    private let weatherService: WebServicable
    
    private var latitude: Double?
    private var longitude: Double?
    private var city: String = ""
    
    @Published var weatherInfo = ""
    
    init(with weatherService: WebServicable) {
        self.weatherService = weatherService
    }
    
    private func geocode(city: String) async {
        
        self.city = city
        
        do {
            let (latitude, longitude) = try await weatherService.fetchGeocode(for: city)
            self.latitude = latitude
            self.longitude = longitude
        } catch {
            print("Error", error.localizedDescription)
        }
        
    }
    
    func fetchWeather(for city: String) async throws {
        
        do {
            
            await geocode(city: city)
            guard latitude != nil, longitude != nil else {
                
                throw WebServicableError.invalidStatusCode
            }
            
            try await fetchWeather(for: latitude!, lon: longitude!)
            
        }  catch {
            
            print("Error", error.localizedDescription)
            throw WebServicableError.forwarded(error)
        }
    }
    
    func fetchWeather(for lat: Double, lon: Double) async throws  {
        
        do {
            let (weatherInfo, _) = try await weatherService.fetchWeatherData(for: (lat, lon))
            
            guard let info = weatherInfo else {
                self.weatherInfo = "Something went wrong. Could not fetch the weather info for \(city)."
                return
            }
            
            self.weatherInfo = info
            
        } catch {
            
            print("Error", error.localizedDescription)
            throw WebServicableError.forwarded(error)
        }
        
    }
}
    
