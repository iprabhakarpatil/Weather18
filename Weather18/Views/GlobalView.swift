//
//  GlobalView.swift
//  Weather18
//
//  Created by Prabhakar Patil on 30/08/23.
//

import SwiftUI

struct GlobalView: View {
    
    @State var city: String
    @ObservedObject var weatherViewModel = WeatherViewModel(with: OpenWeatherMapServices())
    
    var body: some View {
        
        VStack {
            TextField("Enter city", text: $city, onCommit: {
                
                if !city.isEmpty {
                    Task {
                        do {
                            try await weatherViewModel.fetchWeather(for: city)
                        } catch {
                            print("Error: ", error.localizedDescription)
                        }
                    }
                }
            })
        
            .padding()
            .font(.body)
            .foregroundColor(.white)
            
            Divider().padding()
            
            Text(weatherViewModel.weatherInfo)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(.white)
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity )
        .background(.linearGradient(colors: [.teal, .teal.opacity(0.5), .teal.opacity(0.2)],
                                    startPoint: .top,
                                    endPoint: .bottom))
        .tabItem {
            Label("Global",
                  systemImage: "globe.asia.australia.fill")
        }
    }
}

struct GlobalView_Previews: PreviewProvider {
    static var previews: some View {
        GlobalView(city: "")
    }
}
