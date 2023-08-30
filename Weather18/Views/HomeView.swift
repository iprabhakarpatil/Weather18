//
//  HomeView.swift
//  Weather18
//
//  Created by Prabhakar Patil on 30/08/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var locationManager =  LocationManagerObservable()
    @ObservedObject var weatherViewModel = WeatherViewModel(with: OpenWeatherMapServices())
    
    private var latitude: Double {
        return locationManager.currentLocation?.coordinate.latitude ?? 0
    }
    
    private var longitude: Double {
        return locationManager.currentLocation?.coordinate.longitude ?? 0
    }
    
    
    var body: some View {
        
        VStack(alignment: .center){
            
            Button("What's my current weather?") {
                
                if locationManager.locationStatus != .authorizedWhenInUse {
                    locationManager.requestLocationAccess()
                    Task {
                        await fetchWeather()
                    }
                } else {
                    Task {
                        await fetchWeather()
                    }
                }
                
            }
            
            Divider()
            
            Text(weatherViewModel.weatherInfo)
            
            
            
        }
        
        
        .padding()
        .tabItem {
            Label("Current", systemImage: "location")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity )
        .background(.linearGradient(colors: [.teal, .teal.opacity(0.5), .teal.opacity(0.2)],
                                    startPoint: .top,
                                    endPoint: .bottom))
    }
    
    
    
    func fetchWeather() async {
        do {
            try await weatherViewModel.fetchWeather(for: latitude, lon: longitude)
            
        } catch {
            print(error.localizedDescription)
        }
    }
        
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
