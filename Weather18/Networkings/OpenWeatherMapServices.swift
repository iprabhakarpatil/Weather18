//
//  OpenWeatherMapServices.swift
//  Weather18
//
//  Created by Prabhakar Patil on 30/08/23.
//

import Foundation

struct OpenWeatherMapServices: WebServicable {
    
    
    /// Fetch the respective geocodes for the city entered to pass it the webservices for fetching the weather info in async
    /// - Parameter city:String
    /// - Returns: throwable (latitude: String?, longitude: String?)
    func fetchGeocode(for city: String) async throws -> (latitude: Double?, longitude: Double?) {
        
        let geocodeEndPoint = "https://api.openweathermap.org/geo/1.0/direct?q=\(city)&appid=\(apikey)"
        
        guard let safeURLString = geocodeEndPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let endPointURL = URL(string: safeURLString) else {
            
            throw WebServicableError.invalidURL(geocodeEndPoint)
        }
        
        
        let (data, response) = try await URLSession.shared.data(from: endPointURL)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw WebServicableError.invalidStatusCode
        }
        
        let decoder = JSONDecoder()
        
        do {
            let geocoding = try decoder.decode([LocationGeocode].self, from: data)
            
            guard let latitude = geocoding.first?.lat,
                  let longitude = geocoding.first?.lon else {
                
                throw WebServicableError.invalidPayload(endPointURL)
            }
            
            print("\(latitude)", "\(longitude)")
            return (latitude,longitude)
            
        } catch let error {
            
            throw WebServicableError.forwarded(error)
        }
    }
    
    
    
    /// Fetch the weather data for the geocodes passed as input in async call
    /// - Parameter geocodes: (latitude: Double, longitude: Double)
    /// - Returns: throwable (String?, WebServicableError?)
    func fetchWeatherData(for geocodes: (latitude: Double, longitude: Double)) async throws -> (String?, WebServicableError?) {
        
        let weatherEndPoint = "https://api.openweathermap.org/data/2.5/weather?lat=\(geocodes.latitude)&lon=\(geocodes.longitude)&appid=\(apikey)"
        
        guard let safeURLString = weatherEndPoint.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let endPointURL = URL(string: safeURLString) else {
            
            throw WebServicableError.invalidURL(weatherEndPoint)
        }
        
        let (weatherData, response) = try await URLSession.shared.data(from: endPointURL)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw WebServicableError.invalidStatusCode
        }
        
        let decoder = JSONDecoder()
        
        do {
            let weatherInfo = try decoder.decode(OpenMapWeatherData.self, from: weatherData)
            guard let weather = weatherInfo.weather.first?.main,
                  let temperature = weatherInfo.main.temp else {
                
                throw WebServicableError.invalidPayload(endPointURL)
            }
            
            let weatherDescription = "\(weather) \(temperature) F"
            return (weatherDescription, nil)
            
        } catch let error {
            
            throw WebServicableError.forwarded(error)
        }
    }
}
