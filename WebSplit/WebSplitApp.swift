//
//  WebSplitApp.swift
//  WebSplit
//
//  Created by Daps Owolabi on 28/10/2021.
//

import SwiftUI

@main
struct WebSplitApp: App {
    
    @StateObject var notificationManager = NotificationManager()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(notificationManager)
        }
    }
}
