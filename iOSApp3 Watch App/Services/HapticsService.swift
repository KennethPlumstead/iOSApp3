import WatchKit

enum HapticsService {
    static func tick() {
        WKInterfaceDevice.current().play(.directionUp)
    }

    static func levelUp() {
        let d = WKInterfaceDevice.current()
        d.play(.start)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.18) { d.play(.start) }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.36) { d.play(.start) }
    }

    static func countdown() {
        WKInterfaceDevice.current().play(.click)
    }

    static func finish() {
        WKInterfaceDevice.current().play(.success)
    }
}
