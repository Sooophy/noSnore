//
//  NoiseDetector.swift
//  noSonore-watch Watch App
//
//  Created by Sophie on 12/18/24.
//

import Foundation

class NoiseDetector {
    private let noiseThreshold: Float = -50.0 // Adjust based on testing
    private let durationThreshold: TimeInterval = 2.0
    private var noiseStartTime: Date?
    
    func detectSnore(level: Float) -> Bool {
        if level > noiseThreshold {
            if noiseStartTime == nil {
                noiseStartTime = Date()
            }
            
            if let startTime = noiseStartTime,
               Date().timeIntervalSince(startTime) >= durationThreshold {
                noiseStartTime = nil
                return true
            }
        } else {
            noiseStartTime = nil
        }
        
        return false
    }
}

