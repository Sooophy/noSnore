//
//  AudioManager.swift
//  noSonore-watch Watch App
//
//  Created by Sophie on 12/18/24.
//

import Foundation
import AVFoundation

class AudioManager: NSObject, ObservableObject {
    private var audioRecorder: AVAudioRecorder?
    private let noiseDetector = NoiseDetector()
    private let hapticManager = HapticManager()
    
    override init() {
        super.init()
        setupAudioSession()
    }
    
    private func setupAudioSession() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
            try audioSession.setActive(true)
        } catch {
            print("Failed to set up audio session: \(error)")
        }
    }
    
    func startMonitoring() {
        let documentPath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let audioFilename = documentPath.appendingPathComponent("temp.wav")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatLinearPCM),
            AVSampleRateKey: 44100,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            audioRecorder?.isMeteringEnabled = true
            audioRecorder?.record()
            startNoiseDetection()
        } catch {
            print("Could not start recording: \(error)")
        }
    }
    
    func stopMonitoring() {
        audioRecorder?.stop()
    }
    
    private func startNoiseDetection() {
        Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { [weak self] timer in
            guard let self = self, let recorder = self.audioRecorder else {
                timer.invalidate()
                return
            }
            
            recorder.updateMeters()
            let averagePower = recorder.averagePower(forChannel: 0)
            
            if self.noiseDetector.detectSnore(level: averagePower) {
                self.hapticManager.vibrate()
            }
        }
    }
}

