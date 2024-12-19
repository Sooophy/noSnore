//
//  ContentView.swift
//  noSonore-watch Watch App
//
//  Created by Sophie on 12/18/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var audioManager = AudioManager()
    @State private var isMonitoring = false
    
    var body: some View {
        VStack {
            Button(action: {
                isMonitoring.toggle()
                if isMonitoring {
                    audioManager.startMonitoring()
                } else {
                    audioManager.stopMonitoring()
                }
            }) {
                Text(isMonitoring ? "Stop" : "Start")
                    .font(.title2)
                    .foregroundColor(.white)
                    .frame(width: 100, height: 100)
                    .background(isMonitoring ? Color.red : Color.green)
                    .clipShape(Circle())
            }
            
            if isMonitoring {
                Text("Monitoring...")
                    .foregroundColor(.gray)
            }
        }
    }
}

#Preview {
    ContentView()
}
