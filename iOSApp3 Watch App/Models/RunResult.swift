import Foundation

struct RunResult: Identifiable, Codable {
    let id: UUID
    let date: Date
    let level: Int
    let shuttle: Int
    let totalShuttles: Int
    let durationSeconds: Int

    init(level: Int, shuttle: Int, totalShuttles: Int, durationSeconds: Int, date: Date = Date()) {
        self.id = UUID()
        self.date = date
        self.level = level
        self.shuttle = shuttle
        self.totalShuttles = totalShuttles
        self.durationSeconds = durationSeconds
    }

    var levelDotShuttle: String { "\(level).\(shuttle)" }
}
