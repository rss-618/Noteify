//
//  HomeView.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    
    @Environment(AppViewModel.self) var appViewModel
    @State var viewModel: ViewModel = .init()

    var body: some View {

        VStack(spacing: 8) {
            HStack(alignment: .bottom) {
                titleButton
                Spacer()
                historyButton
            }
            DrawBoard()
        }
        .padding(16)
        .navigationTitle("Notepad")
        .sheet(isPresented: $viewModel.isHistoryOpen) {
            HistorySheetView()
        }
        .sheet(isPresented: $viewModel.isEditingTitle) {
            NotepadDetails(title: appViewModel.currentNote.title)
        }
    }
    
    var titleButton: some View {
        Button {
            viewModel.editTitle()
        } label: {
            Text(appViewModel.currentNote.title)
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
