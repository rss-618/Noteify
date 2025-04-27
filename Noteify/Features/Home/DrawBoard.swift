import SwiftUI
import SwiftData

public struct DrawBoard: View {
    
    @Binding var lines: [Line]
    @State var currentColor: Color = .black
    @State var currentWidth: CGFloat = 1.0
    @State var showConfigSheet: Bool = false
    
    public init(lines: Binding<[Line]>) {
        self._lines = lines
    }
    
    public var body: some View {
        VStack(spacing: 2) {
            actionRow
            
            Canvas(opaque: false,
                   colorMode: .extendedLinear,
                   rendersAsynchronously: true,
                   renderer: self.renderer)
            .maxFrame()
            .background {
                RoundedRectangle(cornerRadius: 5)
                    .fill(.white)
            }
            .gesture(dragGesture)
        }
        .sheet(isPresented: $showConfigSheet) {
            VStack(spacing: 10) {
                Text("Configuration")
                    .font(.title2)
                
                configRow(title: "Color Picker") {
                    colorPicker
                }
                
                configRow(title: "Line Width") {
                    HStack {
                        Slider(value: $currentWidth, in: 0.1...10)
                            .frame(width: 200)
                        
                        Text(String(format: "%.2f", currentWidth))
                            .font(.body)
                    }
                }
                
                // More stuff when i want it man
                Spacer()
            }
            .presentationDetents([.medium])
            .presentationDragIndicator(.visible)
            .padding(16)
        }
    }
    
    func configRow(title: String, content: () -> some View) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(title)
                .font(.title3)
            
            content()
                .maxWidth(alignment: .leading)
        }
        .maxWidth()
    }
    
    func renderer(_ context: inout GraphicsContext, _ size: CGSize) {
        for line in lines {
            context.stroke(line.smoothPath,
                           with: .color(line.color),
                           style: .init(lineWidth: line.lineWidth,
                                        lineCap: .round,
                                        lineJoin: .round))
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
            
            moreButton
            
            Spacer()
            
            undoButton
        }
        .background(RoundedRectangle(cornerRadius: 10.0).fill(Color.gray.opacity(0.7)))
    }
    
    var moreButton: some View {
        Button {
            showConfigSheet = true
        } label: {
            Image(systemName: Keys.SystemIcon.ELLIPSIS_CIRCLE)
                .resizable()
                .frame(width: 30, height: 30)
                .padding(7)
        }
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
