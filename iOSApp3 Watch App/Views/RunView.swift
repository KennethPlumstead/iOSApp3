import SwiftUI

struct RunView: View {
    @EnvironmentObject var vm: RunViewModel

    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Text("Level \(level) • Shuttle \(vm.shuttleInLevel + 1)/\(shuttles)")
                    .font(.footnote)
                Spacer()
            }

            ProgressRing(progress: vm.progressToNextBeep, lineWidth: 12)
                .frame(height: 90)
                .overlay(
                    VStack(spacing: 2) {
                        Text("Next beep").font(.caption2).foregroundStyle(.secondary)
                        Text(remaining).monospacedDigit().font(.headline)
                    }
                )

            StatRow(title: "Pace (s/20m)", value: String(format: "%.2f", seconds))
            StatRow(title: "Done", value: "\(vm.totalShuttlesDone)")
            StatRow(title: "Time", value: "\(vm.elapsedSec)s")

            HStack {
                Button("Made it") { vm.madeIt() }
                    .buttonStyle(.borderedProminent)
                    .clipShape(RoundedRectangle(cornerRadius: 12))

                Button("Missed") { vm.missed() }
                    .buttonStyle(.bordered)
                    .tint(.red)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        }
        .padding()
    }

    private var level: Int { BeepSchedule.levels[vm.currentLevelIndex].level }
    private var shuttles: Int { BeepSchedule.levels[vm.currentLevelIndex].shuttles }
    private var seconds: Double { BeepSchedule.levels[vm.currentLevelIndex].secondsPerShuttle }
    private var remaining: String {
        let left = max(0, seconds - seconds * vm.progressToNextBeep)
        return String(format: "%.1fs", left)
    }
}

#if DEBUG
struct RunView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = RunViewModel()
        vm.setPreviewRunning(levelIndex: 2, shuttleInLevel: 3, progress: 0.55, totalDone: 12, elapsed: 47)
        return RunView()
            .environmentObject(vm)
            .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 9 (45mm)"))
            .previewDisplayName("Running")
    }
}
#endif
