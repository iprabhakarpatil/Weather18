//
//  HomeView.swift
//  Weather18
//
//  Created by Prabhakar Patil on 30/08/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showLocationError: Bool = false
    @StateObject private var locationManager =  LocationManagerObservable()
    @ObservedObject var weatherViewModel = WeatherViewModel(with: OpenWeatherMapServices())
    
    private var latitude: Double {
        return locationManager.currentLocation?.coordinate.latitude ?? -1
    }
    
    private var longitude: Double {
        return locationManager.currentLocation?.coordinate.longitude ?? -1
    }
    
    
    var body: some View {
        
        VStack(alignment: .center){
            
            Button("What's my current weather?") {
                
                if locationManager.locationStatus != .authorizedWhenInUse {
                    
                    showLocationError = true
                } else {
                    showLocationError = false
                    Task {
                        await fetchWeather()
                    }
                }
                
            }
            .alert("Provide location access from setting",isPresented: $showLocationError) {
                Button("OK", role: .cancel){ }
            }
            
            Divider()
            
            Text(weatherViewModel.weatherInfo)
        }
        .onAppear(perform: {
            locationManager.requestLocationAccess()
        })
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
