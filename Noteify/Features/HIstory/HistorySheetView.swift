//
//  HistorySheetView.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI
import SwiftData

struct HistorySheetView: View {
    
    @Environment(AppViewModel.self) var appViewModel
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 8) {
            title
            
            HStack {
                Spacer()
                addNotepadButton
            }
            
            List {
                ForEach(appViewModel.notePads) { item in
                    historyRow(item)
                }
                .onDelete {
                    appViewModel.deleteNotepads($0)
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
            appViewModel.newNotepad()
            dismiss()
        } label: {
            Image(systemName: Keys.SystemIcon.PLUS)
                .frame(width: 30, height: 30)
                .padding(7)
        }
    }
    
    func historyRow(_ item: Notepad) -> some View {
        Button {
            appViewModel.selectNotepad(item)
            dismiss()
        } label: {
            Text(item.title)
                .font(.body)
                .padding(.horizontal, 5)
                .padding(.vertical, 8)
                .maxWidth(alignment: .leading)
        }
    }
}

