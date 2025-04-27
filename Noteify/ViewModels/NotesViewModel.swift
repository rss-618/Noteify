//
//  Initializer.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI
import SwiftData

@Observable
final class NotesViewModel: NotesViewModelProtocol {

    var notePads: [Notepad]
    private var _currentNotepad: Int
    // Avoids getting/setting notepads outside of our query stuff
    var currentNotepad: Notepad {
        get {
            notePads[_currentNotepad]
        }
        set {
            notePads[_currentNotepad] = newValue
        }
    }
    
    public init(notePads: [Notepad]) {
        // What am i doin here do i want to do this
        self._currentNotepad = .zero
        guard !notePads.isEmpty else {
            self.notePads = [Notepad(timestamp: Date())]
            return
        }
        self.notePads = notePads
    }
}
