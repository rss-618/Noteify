//
//  NotesViewModelProtocol.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI

protocol NotesViewModelProtocol {
    // TOOD: make not dumb
    var notePads: [Notepad] { get set }
    var currentNotepad: Notepad { get set }
}
