//
//  HistorySheetView.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI
import SwiftData

struct HistorySheetView: View {
    
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Notepad]
    
    @Binding var currentNote: Notepad
    
    var body: some View {
        List {
            ForEach(items) { item in
                Button {
                    currentNote = item
                } label: {
                    Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                }
            }
            .onDelete(perform: deleteItems)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                EditButton()
            }
            ToolbarItem {
                Button(action: addItem) {
                    Label("Add Item", systemImage: "plus")
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Notepad(timestamp: Date())
            modelContext.insert(newItem)
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

