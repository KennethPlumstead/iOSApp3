import Foundation
import Combine

final class RunViewModel: ObservableObject {

    enum Phase {
        case idle
        case countdown(Int)   // 3,2,1
        case running
        case finished(RunResult)
    }

    // Public state
    @Published private(set) var phase: Phase = .idle
    @Published private(set) var currentLevelIndex: Int = 0
    @Published private(set) var shuttleInLevel: Int = 0
    @Published private(set) var totalShuttlesDone: Int = 0
    @Published private(set) var progressToNextBeep: Double = 0   // 0...1
    @Published private(set) var elapsedSec: Int = 0

    private let schedule = BeepSchedule.levels
    private var missesInRow = 0

    // Timing
    private var ticker: AnyCancellable?
    private var startTime: Date?
    private var shuttleStart: Date?
    private var currentShuttleDuration: TimeInterval = 0

    // MARK: - Public API

    func start() {
        // Reset counters
        currentLevelIndex = 0
        shuttleInLevel = 0
        totalShuttlesDone = 0
        progressToNextBeep = 0
        elapsedSec = 0
        missesInRow = 0

        phase = .countdown(3)
        HapticsService.countdown()
        kickOffCountdown()
    }

    func madeIt() {
        missesInRow = 0
    }

    func missed() {
        missesInRow += 1
        if missesInRow >= 2 {
            finishRun()
        }
    }

    func resetToIdle() { phase = .idle }

    // MARK: - Private

    private func kickOffCountdown() {
        var counter = 3
        ticker?.cancel()
        ticker = Timer.publish(every: 1.0, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                guard let self else { return }
                counter -= 1
                if counter > 0 {
                    self.phase = .countdown(counter)
                    HapticsService.countdown()
                } else {
                    self.ticker?.cancel()
                    self.beginRunning()
                }
            }
    }

    private func beginRunning() {
        phase = .running
        startTime = Date()
        startShuttle()
        ticker?.cancel()
        ticker = Timer.publish(every: 0.05, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] now in
                self?.tick(now: now)
            }
    }

    private func startShuttle() {
        let spec = schedule[currentLevelIndex]
        currentShuttleDuration = spec.secondsPerShuttle
        shuttleStart = Date()
        progressToNextBeep = 0

        if shuttleInLevel == 0 && totalShuttlesDone > 0 {
            HapticsService.levelUp()
        } else {
            HapticsService.tick()
        }
    }

    private func tick(now: Date) {
        guard case .running = phase,
              let shuttleStart else { return }

        if let startTime {
            elapsedSec = Int(now.timeIntervalSince(startTime))
        }

        let elapsed = now.timeIntervalSince(shuttleStart)
        progressToNextBeep = min(1, max(0, elapsed / currentShuttleDuration))

        if elapsed >= currentShuttleDuration {
            totalShuttlesDone += 1
            shuttleInLevel += 1
            missesInRow = 0

            let spec = schedule[currentLevelIndex]
            if shuttleInLevel >= spec.shuttles {
                if currentLevelIndex < schedule.count - 1 {
                    currentLevelIndex += 1
                    shuttleInLevel = 0
                } else {
                    finishRun()
                    return
                }
            }
            startShuttle()
        }
    }

    private func finishRun() {
        ticker?.cancel()
        let lvl = schedule[currentLevelIndex].level
        let result = RunResult(level: lvl,
                               shuttle: max(1, shuttleInLevel),
                               totalShuttles: totalShuttlesDone,
                               durationSeconds: elapsedSec)
        HapticsService.finish()
        phase = .finished(result)
    }
}

// MARK: - Preview helpers (no timers)
extension RunViewModel {
    func setPreviewCountdown(_ n: Int) {
        phase = .countdown(max(1, min(3, n)))
    }

    func setPreviewRunning(levelIndex: Int, shuttleInLevel: Int, progress: Double, totalDone: Int, elapsed: Int) {
        self.phase = .running
        self.currentLevelIndex = max(0, min(BeepSchedule.levels.count - 1, levelIndex))
        self.shuttleInLevel = max(0, shuttleInLevel)
        self.progressToNextBeep = max(0, min(1, progress))
        self.totalShuttlesDone = max(0, totalDone)
        self.elapsedSec = max(0, elapsed)
    }

    func setPreviewFinished(level: Int, shuttle: Int, totalDone: Int, elapsed: Int) {
        let r = RunResult(level: level, shuttle: shuttle, totalShuttles: totalDone, durationSeconds: elapsed)
        self.phase = .finished(r)
    }
}
