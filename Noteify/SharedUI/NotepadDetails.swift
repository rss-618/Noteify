//
//  NotepadDetails.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 5/11/25.
//

import SwiftUI

struct NotepadDetails: View {
    
    @Binding var notepad: Notepad
    @State var titleText: String
    
    public init(notepad: Binding<Notepad>) {
        self._notepad = notepad
        self.titleText = notepad.wrappedValue.title
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            HStack {
                Spacer()
                Button {
                    notepad.title = titleText
                } label: {
                    Text("Save")
                }
            }
            VStack {
                row("title") {
                    TextField("Notepad Title", text: $titleText)
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
