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
    
    var smoothPath: Path {
        var path = Path()
        if let first = points.first {
            path.move(to: first)
        }
        
        for index in 1..<points.count {
            let midPoint = calculateMidPoint(points[index - 1], points[index])
            path.addQuadCurve(to: midPoint, control: points[index - 1])
        }
        
        if let last = points.last {
            path.addLine(to: last)
        }
        
        return path
    }
    
    private func calculateMidPoint(_ point1: CGPoint, _ point2: CGPoint) -> CGPoint {
        CGPoint(x: (point1.x + point2.x) / 2, y: (point1.y + point2.y) / 2)
    }
    
    public init(color: Color,
                lineWidth: CGFloat = 1.0,
                points: [CGPoint] = .init()) {
        self.points = points
        self.color = color
        self.lineWidth = lineWidth
    }
}
