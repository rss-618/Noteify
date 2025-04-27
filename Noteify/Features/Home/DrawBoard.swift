import SwiftUI
import SwiftData

public struct DrawBoard: View {
    
    @Binding var lines: [Line]
    @State var currentColor: Color = .black
    @State var currentWidth: CGFloat = 1.0
    
    public init(lines: Binding<[Line]>) {
        self._lines = lines
    }
    
    public var body: some View {
        VStack(spacing: .zero) {
            actionRow
            
            Canvas(opaque: false,
                   colorMode: .extendedLinear,
                   rendersAsynchronously: true,
                   renderer: self.renderer)
            .maxFrame()
            .gesture(dragGesture)
        }
    }
    
    func renderer(_ context: inout GraphicsContext, _ size: CGSize) {
        for line in lines {
            context.stroke(line.path,
                           with: .color(line.color),
                           lineWidth: line.lineWidth)
        }
    }
    
    var dragGesture: some Gesture {
        DragGesture(minimumDistance: .zero,
                    coordinateSpace: .local)
        .onChanged { value in 
            guard let index = lines.indices.last,
                    value.translation.width + value.translation.height != .zero else {
                // This is a new line
                lines.append(.init(color: currentColor, lineWidth: currentWidth, points: [value.location]))
                return
            }
            
            lines[index].points.append(value.location)
        }
    }
    
    var actionRow: some View {
        HStack {
            colorPicker

            Spacer()
            
            undoButton
        }
        .background(RoundedRectangle(cornerRadius: 10.0).fill(Color.gray.opacity(0.7)))
    }
    
    var undoButton: some View {
        Button {
            if !lines.isEmpty {
                lines.removeLast()
            }
        } label: {
            Image(systemName: Keys.SystemIcon.ARROW_UTURN_BACKWARD_CIRCLE)
                .resizable()
                .frame(width: 30, height: 30)
                .padding(7)
        }
    }
    
    var colorPicker: some View {
        ColorPicker("Select a Color", selection: $currentColor, supportsOpacity: true)
            .frame(width: 30, height: 30)
            .padding(7)
    }
}

struct DrawPreview: PreviewProvider {
    static var previews: some View {
        DrawBoard(lines: .constant([.init(color: .black,
                                          lineWidth: 1.0,
                                          points: [.init(x: 10, y: 10),
                                                   .init(x: 100, y: 100)])]))
    }
}
