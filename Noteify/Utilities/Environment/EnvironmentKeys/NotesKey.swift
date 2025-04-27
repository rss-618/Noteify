//
//  NotesKey.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI

struct NotesKey: EnvironmentKey {
    static var defaultValue: NotesViewModelProtocol = NotesViewModel(notePads: .init())
    static var mockValue: NotesViewModelProtocol = MockNotesViewModel()
}
