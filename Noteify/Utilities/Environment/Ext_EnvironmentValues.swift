//
//  Untitled.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI

extension EnvironmentValues {
    var notes: NotesViewModelProtocol {
        get { self[NotesKey.self] }
        set { self[NotesKey.self] = newValue }
    }
}
