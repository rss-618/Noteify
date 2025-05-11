//
//  HomeView.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @State private var viewModel = ViewModel(swiftDataService: .live)

    var body: some View {
        VStack(spacing: 8) {
            HStack(alignment: .bottom) {
                titleButton
                Spacer()
                historyButton
            }
            DrawBoard(lines: $viewModel.currentNote.lines)
        }
        .padding(16)
        .navigationTitle("Notepad")
        .sheet(isPresented: $viewModel.isHistoryOpen) {
            HistorySheetView(items: viewModel.notePads,
                             addCompletion: {
                viewModel.newNotepad()
                viewModel.dismissHistory()
            },
                             selectCompletion: {
                viewModel.selectNotepad($0)
                viewModel.dismissHistory()
            },
                             deleteCompletion: {
                viewModel.deleteNotepads($0)
            })
        }
        .sheet(isPresented: $viewModel.isEditingTitle) {
            NotepadDetails(notepad: $viewModel.currentNote)
        }
    }
    
    var titleButton: some View {
        Button {
            viewModel.editTitle()
        } label: {
            Text(viewModel.currentNote.title)
                .font(.title2)
                .fontWeight(.semibold)
                .kerning(0.7)
        }
    }
    
    var historyButton: some View {
        Button {
            viewModel.openHistory()
        } label: {
            Text("history")
        }
    }

}
