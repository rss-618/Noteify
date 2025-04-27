//
//  Ext_View.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import SwiftUI

extension View {
    
    func maxFrame() -> some View {
        return self.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func maxWidth(alignment: Alignment = .center) -> some View {
        return self.frame(maxWidth: .infinity, alignment: alignment)
    }
    
    func maxHeight(alignment: Alignment = .center) -> some View {
        return self.frame(maxHeight: .infinity, alignment: alignment)
    }
    
}
