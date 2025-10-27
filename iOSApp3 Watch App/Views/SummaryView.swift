import SwiftUI

struct SummaryView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var vm: RunViewModel
    @EnvironmentObject var store: ResultsStore

    var body: some View {
        VStack(spacing: 8) {
            if case let .finished(r) = vm.phase {
                Text("Result").font(.title3).bold()
                Text("Level \(r.level) • Shuttle \(r.shuttle)").font(.headline)

                StatRow(title: "Total shuttles", value: "\(r.totalShuttles)")
                StatRow(title: "Time", value: "\(r.durationSeconds)s")
                    .padding(.bottom, 6)

                Button("Save to History") {
                    store.add(r)
                    exitToStart()
                }
                .buttonStyle(.borderedProminent)
                .clipShape(RoundedRectangle(cornerRadius: 12))

                Button("Done") { exitToStart() }
                    .buttonStyle(.bordered)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            } else {
                Text("No result").foregroundStyle(.secondary)
            }
        }
        .padding()
    }

    private func exitToStart() {
        vm.resetToIdle()
        dismiss()
    }
}

#if DEBUG
struct SummaryView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = RunViewModel()
        let store = ResultsStore()
        vm.setPreviewFinished(level: 5, shuttle: 4, totalDone: 39, elapsed: 210)
        return SummaryView()
            .environmentObject(vm)
            .environmentObject(store)
            .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 9 (45mm)"))
    }
}
#endif
