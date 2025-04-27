//
//  Line.swift
//  Noteify
//
//  Created by Ryan Schildknecht on 4/26/25.
//

import SwiftUI

public struct Line: Equatable, Codable, Hashable {
    var points: [CGPoint]
    var color: Color
    var lineWidth: CGFloat
    
    var path: Path {
        var path = Path()
        path.addLines(points)
        return path
    }
    
    public init(color: Color,
                lineWidth: CGFloat = 1.0,
                points: [CGPoint] = .init()) {
        self.points = points
        self.color = color
        self.lineWidth = lineWidth
    }
}
