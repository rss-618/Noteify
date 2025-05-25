import SwiftUI
import SwiftData

public struct DrawBoard: View {
    
    @Environment(AppViewModel.self) var appViewModel
    @State var viewModel: ViewModel = .init()
    
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
        .sheet(isPresented: $viewModel.isConfigSheetShowing) {
            VStack(spacing: 10) {
                Text("Configuration")
                    .font(.title2)
                
                configRow(title: "Color Picker") {
                    colorPicker
                }
                
                configRow(title: "Line Width") {
                    HStack {
                        Slider(value: $viewModel.config.currentWidth, in: 0.1...10)
                            .frame(width: 200)
                        
                        Text(String(format: "%.2f", viewModel.config.currentWidth))
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
        for line in appViewModel.currentNote.lines {
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
            appViewModel.drawLine(value: value, config: viewModel.config)
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
            viewModel.displayConfigSheet()
        } label: {
            Image(systemName: Keys.SystemIcon.ELLIPSIS_CIRCLE)
                .resizable()
                .frame(width: 30, height: 30)
                .padding(7)
        }
    }
    
    var undoButton: some View {
        Button {
            appViewModel.undoLine()
        } label: {
            Image(systemName: Keys.SystemIcon.ARROW_UTURN_BACKWARD_CIRCLE)
                .resizable()
                .frame(width: 30, height: 30)
                .padding(7)
        }
    }
    
    var colorPicker: some View {
        ColorPicker("Select a Color", selection: $viewModel.config.currentColor, supportsOpacity: true)
            .frame(width: 30, height: 30)
            .padding(7)
    }
}
