import SwiftUI

struct ProgressRing: View {
    var progress: Double  // 0...1
    var lineWidth: CGFloat = 10

    var body: some View {
        ZStack {
            Circle()
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .opacity(0.2)

            Circle()
                .trim(from: 0, to: progress)
                .stroke(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round))
                .rotationEffect(.degrees(-90))
                .animation(.linear(duration: 0.1), value: progress)
        }
    }
}

#if DEBUG
struct ProgressRing_Previews: PreviewProvider {
    static var previews: some View {
        ProgressRing(progress: 0.66)
            .frame(width: 120, height: 120)
            .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 9 (45mm)"))
    }
}
#endif
