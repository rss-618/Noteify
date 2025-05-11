//
//  HistorySheetView.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI
import SwiftData

struct HistorySheetView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    let items: [Notepad]
    let addCompletion: () -> Void
    let selectCompletion: (Notepad) -> Void
    let deleteCompletion: (IndexSet) -> Void
    
    var body: some View {
        VStack(spacing: 8) {
            title
            
            HStack {
                Spacer()
                addNotepadButton
            }
            
            List {
                ForEach(items) { item in
                    historyRow(item)
                }
                .onDelete {
                    deleteCompletion($0)
                }
            }
            .maxFrame()
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
        Button {
            addCompletion()
        } label: {
            Image(systemName: Keys.SystemIcon.PLUS)
                .frame(width: 30, height: 30)
                .padding(7)
        }
    }
    
    func historyRow(_ item: Notepad) -> some View {
        Button {
            selectCompletion(item)
        } label: {
            Text(item.title)
                .font(.body)
                .padding(.horizontal, 5)
                .padding(.vertical, 8)
                .maxWidth(alignment: .leading)
        }
    }
}

