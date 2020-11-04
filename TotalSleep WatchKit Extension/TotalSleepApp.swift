//
//  TotalSleepApp.swift
//  TotalSleep WatchKit Extension
//
//  Created by Sacha Schwab on 04.11.20.
//

import SwiftUI

@main
struct TotalSleepApp: App {
    @SceneBuilder var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
            }
        }

        WKNotificationScene(controller: NotificationController.self, category: "myCategory")
    }
}
