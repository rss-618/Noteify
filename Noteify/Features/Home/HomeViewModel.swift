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
        var isEditingTitle: Bool = false
        
        
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
            fetchNotepads()
        }
        
        func fetchNotepads() {
            self.notePads = swiftDataService.fetchNotepads(sortBy: [currentSort])
        }
        
        func selectNotepad(_ notepad: Notepad) {
            self.currentNote = notepad
        }
        
        func editTitle() {
            self.isEditingTitle = true
        }
        
        // Currently we wont allow a non-empty list, this should be subject to change
        func deleteNotepads(_ indexSet: IndexSet) {
            let notepadsToDelete: [Notepad] = indexSet.compactMap { notePads[$0] }
            let selectDifferentNotepad = notepadsToDelete.contains(currentNote)
            let hasFreeNotepads = notepadsToDelete.count < notePads.count
            // Ensure we keep a notepad selected
            if selectDifferentNotepad {
                if hasFreeNotepads {
                    for notePad in notePads where !notepadsToDelete.contains(notePad) {
                        currentNote = notePad
                    }
                } else {
                    newNotepad()
                }
            }
            // Remove notepads selected for deletion
            for notePad in notepadsToDelete {
                swiftDataService.removeNotepad(notePad)
                fetchNotepads()
            }
        }
    }
}
