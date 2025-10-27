import SwiftUI

struct CountdownView: View {
    @EnvironmentObject var vm: RunViewModel

    var body: some View {
        ZStack {
            if case let .countdown(n) = vm.phase {
                Text("\(n)")
                    .font(.system(size: 64, weight: .bold, design: .rounded))
                    .transition(.scale.combined(with: .opacity))
                    .id(n)
            }
        }
        .padding()
        .animation(.easeInOut(duration: 0.3), value: phaseKey)
    }

    private var phaseKey: String {
        if case let .countdown(n) = vm.phase { return "cd\(n)" }
        return "none"
    }
}

#if DEBUG
struct CountdownView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = RunViewModel()
        vm.setPreviewCountdown(2)
        return CountdownView()
            .environmentObject(vm)
            .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 9 (45mm)"))
    }
}
#endif
