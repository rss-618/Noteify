//
//  HomeViewModel.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 4/26/25.
//

import SwiftUI

extension HomeView {
    @Observable
    class ViewModel {
        var currentNote: Notepad = .init()
        var isHistoryOpen: Bool = false
    }
}
