//
//  HomeView.swift
//  Weather18
//
//  Created by Prabhakar Patil on 30/08/23.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var locationManager =  LocationManagerObservable()
    
    private var latitude: String? {
        return "\(locationManager.currentLocation?.coordinate.latitude)"
    }
    
    private var longitude: String? {
        return "\(locationManager.currentLocation?.coordinate.longitude)"
    }
    
    
    var body: some View {
        
        VStack(alignment: .leading){
            
            
            
        }
        
        .tabItem {
            Label("Current", systemImage: "location")
        }
        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity )
        .background(.linearGradient(colors: [.teal, .teal.opacity(0.5), .teal.opacity(0.2)],
                                    startPoint: .top,
                                    endPoint: .bottom))
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
