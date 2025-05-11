//
//  HomeViewModel.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 4/26/25.
//

import SwiftUI
import SwiftData

extension HomeView {
    @Observable
    class ViewModel {
        
        var swiftDataService: SwiftDataService
        
        var currentSort: SortDescriptor<Notepad>

        var currentNote: Notepad
        var notePads: [Notepad]
        var isHistoryOpen: Bool = false
        
        
        public init<DataService: SwiftDataService>(swiftDataService: DataService,
                                                   defaultSort: SortDescriptor<Notepad> = .init(\.lastModifiedTimestamp, order: .reverse)) {
            self.currentSort = defaultSort
            self.swiftDataService = swiftDataService
            let notePads: [Notepad] = swiftDataService.fetchNotepads(sortBy: [defaultSort])
            if let currentNote = notePads.first {
                self.currentNote = currentNote
            } else {
                let notepad = Notepad()
                swiftDataService.addNotepad(notepad)
                self.currentNote = notepad
            }
            self.notePads = swiftDataService.fetchNotepads(sortBy: [defaultSort])
        }
        
        func openHistory() {
            isHistoryOpen = true
        }
        
        func dismissHistory() {
            isHistoryOpen = false
        }
        
        func newNotepad() {
            let notepad = Notepad()
            swiftDataService.addNotepad(notepad)
            self.currentNote = notepad
            self.notePads = swiftDataService.fetchNotepads(sortBy: [currentSort])
        }
        
        func selectNotepad(_ notepad: Notepad) {
            self.currentNote = notepad
        }
    }
}
