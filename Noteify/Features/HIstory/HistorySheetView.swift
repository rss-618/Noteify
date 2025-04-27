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
    @Environment(\.dismiss) private var dismiss
    
    @Query private var items: [Notepad]
    
    @Binding var currentNote: Notepad
    
    var body: some View {
        VStack(spacing: 8) {
            title
            
            HStack {
                Spacer()
                addNotepadButton
            }
            
            ScrollView {
                LazyVStack(spacing: 5) {
                    // Sorting these items on the view level is gross but idk any other way with query
                    // will investigate
                    ForEach(items.sorted { $0.timestamp > $1.timestamp }) { item in
                        historyRow(item)
                    }
                    
                    Spacer()
                }
                .maxFrame()
            }
        }
        .padding(16)
        .maxFrame()
        .presentationDetents([.medium])
    }
    
    var title: some View {
        Text("Notepads")
            .font(.title)
    }
    
    var addNotepadButton: some View {
        Button(action: addItem) {
            Image(systemName: Keys.SystemIcon.PLUS)
                .frame(width: 30, height: 30)
                .padding(7)
        }
    }
    
    func historyRow(_ item: Notepad) -> some View {
        Button {
            itemSelected(item)
        } label: {
            Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
                .font(.body)
                .padding(.horizontal, 5)
                .padding(.vertical, 8)
                .maxWidth(alignment: .leading)
                .background {
                    RoundedRectangle(cornerRadius: 5)
                        .fill(.gray)
                }
        }
    }
    
    private func itemSelected(_ notepad: Notepad) {
        currentNote = notepad
        dismiss()
    }
    
    private func addItem() {
        withAnimation {
            let newItem = Notepad(timestamp: Date())
            modelContext.insert(newItem)
            itemSelected(newItem)
        }
    }

    // TODO: Eventually Re-add this in some type of manner
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(items[index])
            }
        }
    }
}

