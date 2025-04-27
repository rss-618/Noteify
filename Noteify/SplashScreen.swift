import SwiftUI

public struct SplashScreen: View {
    
    @State var isAnimating = false
    
    public var body: some View {
        VStack {
            Image(systemName: "note.text")
                .symbolEffect(.bounce, value: isAnimating)
                .frame(width: 50, height: 50)
                .onAppear {
                    withAnimation(.default.repeatForever()) {
                        isAnimating = true
                    }
                }
                
        }
    }
}
