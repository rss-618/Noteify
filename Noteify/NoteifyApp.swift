//
//  NoteifyApp.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI
import SwiftData

@main
struct NoteifyApp: App {
    
    var body: some Scene {
        WindowGroup {
            NavigationSplitView {
                HomeView()
                    .environment(AppViewModel(swiftDataService: .live))
            } detail: {
                Text("Take your notes here")
            }
        }
    }
}
