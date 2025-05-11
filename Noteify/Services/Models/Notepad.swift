//
//  Item.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 1/25/25.
//

import Foundation
import SwiftData

@Model
final class Notepad {
    var id: UUID
    var title: String
    var lines: [Line]
    var createdTimestamp: Date
    var lastModifiedTimestamp: Date
    
    // What do i need?
    // something for the canvas to redraw the lines on the notepad
    // an attributed string to take care of the true text input
    // the time stamp i already have on the model is probably cool
    // maybe alter it to created and lastUpdate, so i have the abliity to sort on history.
    
    // i think the main guise of the app is
    // - have a notepad you can scribble on
    // - have a textpad that you can type on
    // - have an auto translate functionality where you can either select a portion of the canvas or the whole thing to get translated into text
    //      - but the tranlation needs to be applied to the textpad very carefully, i am envisioning a drag and drop feature where the auto translation pops up in a floating card between the two areas. would need to implemented an edge aware auto scroll when we do the autotranslate drag.
    // - the main page will always be the notepad/text pad, but to access previous notes to switch between them we would either have an always peeked sheet, or a buton that reveals the sheet.
    //      - the sheet needs to be multi-detent where its easy to expand and scroll
    //      - and upon press we auto shut or minify the sheet and replace current note screen with the selected instance.
    
    // Keep this app simple only complexities should be with draw options, auto parsing of draw pad to text, and custom fonts & colors within text pad.
    // This app needs to be a single page app.
    init(
        id: UUID = .init(),
        title: String? = nil,
        lines: [Line] = .init(),
        createdTimestamp: Date = .init(),
        lastModifiedTimestamp: Date = .init(),
        
    ) {
        self.id = id
        self.title = title ?? createdTimestamp.ISO8601Format()
        self.lines = lines
        self.createdTimestamp = createdTimestamp
        self.lastModifiedTimestamp = lastModifiedTimestamp
    }
}
