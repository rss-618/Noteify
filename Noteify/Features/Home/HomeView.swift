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
    
    @State var currentNote: Notepad = .init()
    @State var isHistoryOpen: Bool = false
    
    var body: some View {
        VStack {
            historyButton
            DrawBoard(lines: $currentNote.lines)
        }
        .navigationTitle("Notepad")
        .sheet(isPresented: $isHistoryOpen) {
            HistorySheetView(currentNote: $currentNote)
                    .maxWidth()
                    .presentationDetents([.medium, .large])
        }
        .task {
            loadCurrentNote()
        }

    }
    
    var historyButton: some View {
        Button {
            isHistoryOpen = true
        } label: {
            Text("history")
        }
    }
    
    private func loadCurrentNote() {
        if let mostRecent = items.sorted(by: { $0.timestamp > $1.timestamp }).first {
            currentNote = mostRecent
        } else {
            let newItem = Notepad(timestamp: Date())
            modelContext.insert(newItem)
            currentNote = newItem
        }
    }

}
