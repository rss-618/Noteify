//
//  HomeView.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(\.modelContext) var modelContext
    @Query var items: [Notepad]
    
    @State private var viewModel = ViewModel()

    var body: some View {
        VStack(spacing: 8) {
            historyButton
            DrawBoard(lines: $viewModel.currentNote.lines)
                .padding(16)
        }
        .navigationTitle("Notepad")
        .sheet(isPresented: $viewModel.isHistoryOpen) {
            HistorySheetView(currentNote: $viewModel.currentNote)
        }
        .task {
            loadCurrentNote()
        }
    }
    
    var historyButton: some View {
        Button {
            viewModel.isHistoryOpen = true
        } label: {
            Text("history")
        }
    }
    
    private func loadCurrentNote() {
        if let mostRecent = items.sorted(by: { $0.timestamp > $1.timestamp }).first {
            viewModel.currentNote = mostRecent
        } else {
            let newItem = Notepad(timestamp: Date())
            modelContext.insert(newItem)
            viewModel.currentNote = newItem
        }
    }

}
