//
//  LocationManagerObservable.swift
//  Weather18
//
//  Created by Prabhakar Patil on 30/08/23.
//

import Foundation
import CoreLocation
import Combine

class LocationManagerObservable: NSObject, ObservableObject  {
    
    private let locationManager = CLLocationManager()
    
    @Published private (set) var locationStatus: CLAuthorizationStatus?
    @Published private (set) var currentLocation: CLLocation?
    
    override init() {
        
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest /// set the location accuracy to best for fetching desired results.
    }
    
    func requestLocationAccess() {
        locationManager.requestWhenInUseAuthorization() /// only authorised to use when weather app is open.
        locationManager.startUpdatingLocation() /// start the location services.
    }
    
}


// MARK: - CLLocationManagerDelegate
extension LocationManagerObservable: CLLocationManagerDelegate {
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
        locationStatus = manager.authorizationStatus
        print("Current authorization status: \(locationStatus ?? .denied)")
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let latestLocation = locations.last else {
            return
        }
        print("Latest user location: \(latestLocation)")
        
        currentLocation = latestLocation
    }
    
}
