//
//  SharedModelContainer.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import Foundation
import SwiftData

struct SharedModelContainer {
    static var instance: ModelContainer = {
        let schema = Schema([
            Notepad.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema,
                                                    isStoredInMemoryOnly: false)
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
}

