//
//  HomeViewModel.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 5/24/25.
//

import SwiftUI

extension HomeView {
    @Observable
    class ViewModel {
        var isHistoryOpen: Bool = false
        var isEditingTitle: Bool = false
        
        func editTitle() {
            self.isEditingTitle = true
        }
        
        func openHistory() {
            isHistoryOpen = true
        }
        
        func dismissHistory() {
            isHistoryOpen = false
        }
    }
}
