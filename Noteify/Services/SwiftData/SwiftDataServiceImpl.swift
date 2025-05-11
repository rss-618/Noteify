//
//  SharedModelContainer.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import Foundation
import SwiftData

class SwiftDataServiceImpl: SwiftDataService {
    
    private let modelContainer: ModelContainer
    private let modelContext: ModelContext
    
    @MainActor
    static let shared: SwiftDataServiceImpl = .init()
    
    @MainActor
    private init() {
        let schema = Schema([
            Notepad.self,
        ])
        self.modelContainer = try! ModelContainer(for: schema,
                                                  configurations: ModelConfiguration(isStoredInMemoryOnly: false))
        self.modelContext = modelContainer.mainContext
    }
    
    func fetchNotepads(predicate: Predicate<Notepad>? = nil,
                       sortBy: [SortDescriptor<Notepad>] = .init()) -> [Notepad] {
        do {
            return try modelContext.fetch(FetchDescriptor<Notepad>(predicate: predicate,
                                                                   sortBy: sortBy))
        } catch {
            // TODO: do i really wanna do this?
            fatalError(error.localizedDescription)
        }
    }
    
    func addNotepad(_ notepad: Notepad) {
        modelContext.insert(notepad)
        saveContext()
    }
    
    func removeNotepad(_ notepad: Notepad) {
        modelContext.delete(notepad)
        saveContext()
    }
    
    private func saveContext() {
        do {
            try modelContext.save()
        } catch {
            // TODO: do i really wanna do this?
            fatalError(error.localizedDescription)
        }
    }
}
