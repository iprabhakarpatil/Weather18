//
//  ContentView.swift
//  Weather18
//
//  Created by Prabhakar Patil on 30/08/23.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        TabView{
            HomeView()
            GlobalView(city: "")
        }
                
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
