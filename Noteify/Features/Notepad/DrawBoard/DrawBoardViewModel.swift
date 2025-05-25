//
//  DrawBoardViewModel.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 5/24/25.
//

import SwiftUI

extension DrawBoard {
    
    struct Config: Equatable {
        var currentColor: Color = .black
        var currentWidth: CGFloat = 1.0
    }
    
    @Observable
    class ViewModel {
        var config: Config = .init()
        var isConfigSheetShowing: Bool = false
        
        func displayConfigSheet() {
            isConfigSheetShowing = true
        }
                
    }
}

