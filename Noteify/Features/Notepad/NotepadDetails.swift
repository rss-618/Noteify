//
//  NotepadDetails.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 5/11/25.
//

import SwiftUI

struct NotepadDetails: View {
    
    @Environment(\.dismiss) var dismiss
    @Environment(AppViewModel.self) var viewModel
    
    @State var title: String
    
    public init(title: String) {
        self.title = title
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            HStack {
                Spacer()
                Button {
                    viewModel.updateNotepad(title: title)
                    dismiss()
                } label: {
                    Text("Save")
                }
            }
            VStack {
                row("title") {
                    TextField("Notepad Title", text: $title)
                        .maxWidth()
                        .textFieldStyle(.roundedBorder)
                }
                
                // TODO: do the rest
                
                Spacer()
            }
        }
        .padding(16)
        .maxFrame()
        .presentationDetents([.medium])
    }
    
    @ViewBuilder
    public func row(_ title: String, @ViewBuilder content: () -> some View) -> some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.title3)
                .fontWeight(.medium)
                .kerning(0.5)
            
            content()
        }
        .maxWidth()
    }
}
