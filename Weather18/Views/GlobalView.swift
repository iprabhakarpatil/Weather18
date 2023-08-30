//
//  GlobalView.swift
//  Weather18
//
//  Created by Prabhakar Patil on 30/08/23.
//

import SwiftUI

struct GlobalView: View {
    
    @State var city: String
    
    var body: some View {
        
        VStack {
            TextField("eg. Bengaluru", text: $city, onCommit: {
                
                if !city.isEmpty {
                    print("Call the api services")
                }
                
            })
            .padding()
            .font(.title)
            .foregroundColor(.white)
            
            Divider().padding()
            
            Text("Enter the city to know the current weather.")
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
