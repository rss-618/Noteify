//
//  MockNotesViewModle.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI
import SwiftData

public class MockNotesViewModel: NotesViewModelProtocol {
    
    var notePads: [Notepad] = [Notepad(timestamp: .init())]
    
    // TODO: de gross when used
    var currentNotepad: Notepad {
        get {
            notePads.first!
        }
        set {
            notePads[.zero] = newValue
        }
    }
}
