//
//  WeeklyPulseApp.swift
//  WeeklyPulse
//
//  Created by Eyüp Erdoğan on 12.08.2024.
//

import SwiftUI

@main
struct WeeklyPulseApp: App {
   
    var body: some Scene {
        WindowGroup {
            ContentView()
                .frame(minWidth: 550, minHeight: 550)
                .multilineTextAlignment(.center)
        }
        .windowResizability(.contentSize)
    }
}
