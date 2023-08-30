//
//  WebServicable.swift
//  Weather18
//
//  Created by Prabhakar Patil on 30/08/23.
//

import Foundation

public enum WebServicableError: Error {
    
    case invalidStatusCode
    case invalidURL(String)
    case invalidPayload(URL)
    case forwarded(Error)
}

public protocol WebServicable {
    
    var apikey: String { get }
    
    func fetchGeocode(for city: String) async throws -> (latitude: String?, longitude: String?)
    func fetchWeatherData(for geocodes: (latitude: Double, longitude: Double)) async throws -> (String?, WebServicableError?)
}

extension WebServicable {
    
    var apikey: String {
        return "e1018664c2956d39c59bcb0ff03ece46"
    }
}
