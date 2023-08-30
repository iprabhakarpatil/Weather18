//
//  HomeView.swift
//  Weather18
//
//  Created by Prabhakar Patil on 30/08/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        Text("Home Location")
        
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
