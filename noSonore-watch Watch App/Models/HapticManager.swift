//
//  HapticManager.swift
//  noSonore-watch Watch App
//
//  Created by Sophie on 12/18/24.
//

import WatchKit

class HapticManager {
    func vibrate() {
        WKInterfaceDevice.current().play(.notification)
    }
}
