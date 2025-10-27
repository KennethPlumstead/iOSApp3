import Foundation

struct LevelSpec: Identifiable, Codable {
    // var avoids decode warning; we don't persist LevelSpec anyway
    var id: UUID = UUID()
    let level: Int
    let shuttles: Int
    let speedKmh: Double
    let secondsPerShuttle: Double

    private enum CodingKeys: String, CodingKey {
        case level, shuttles, speedKmh, secondsPerShuttle
    }
}

/// 20 m Léger schedule (enough for normal use)
enum BeepSchedule {
    static let levels: [LevelSpec] = [
        .init(level: 1,  shuttles: 7,  speedKmh: 8.5,  secondsPerShuttle: 72.0 / 8.5),
        .init(level: 2,  shuttles: 8,  speedKmh: 9.0,  secondsPerShuttle: 72.0 / 9.0),
        .init(level: 3,  shuttles: 8,  speedKmh: 9.5,  secondsPerShuttle: 72.0 / 9.5),
        .init(level: 4,  shuttles: 8,  speedKmh: 10.0, secondsPerShuttle: 72.0 / 10.0),
        .init(level: 5,  shuttles: 9,  speedKmh: 10.5, secondsPerShuttle: 72.0 / 10.5),
        .init(level: 6,  shuttles: 9,  speedKmh: 11.0, secondsPerShuttle: 72.0 / 11.0),
        .init(level: 7,  shuttles: 10, speedKmh: 11.5, secondsPerShuttle: 72.0 / 11.5),
        .init(level: 8,  shuttles: 10, speedKmh: 12.0, secondsPerShuttle: 72.0 / 12.0),
        .init(level: 9,  shuttles: 10, speedKmh: 12.5, secondsPerShuttle: 72.0 / 12.5),
        .init(level: 10, shuttles: 11, speedKmh: 13.0, secondsPerShuttle: 72.0 / 13.0),
        .init(level: 11, shuttles: 11, speedKmh: 13.5, secondsPerShuttle: 72.0 / 13.5),
        .init(level: 12, shuttles: 12, speedKmh: 14.0, secondsPerShuttle: 72.0 / 14.0),
        .init(level: 13, shuttles: 12, speedKmh: 14.5, secondsPerShuttle: 72.0 / 14.5),
        .init(level: 14, shuttles: 13, speedKmh: 15.0, secondsPerShuttle: 72.0 / 15.0),
        .init(level: 15, shuttles: 13, speedKmh: 15.5, secondsPerShuttle: 72.0 / 15.5),
        .init(level: 16, shuttles: 14, speedKmh: 16.0, secondsPerShuttle: 72.0 / 16.0),
        .init(level: 17, shuttles: 14, speedKmh: 16.5, secondsPerShuttle: 72.0 / 16.5),
        .init(level: 18, shuttles: 15, speedKmh: 17.0, secondsPerShuttle: 72.0 / 17.0),
        .init(level: 19, shuttles: 15, speedKmh: 17.5, secondsPerShuttle: 72.0 / 17.5),
        .init(level: 20, shuttles: 16, speedKmh: 18.0, secondsPerShuttle: 72.0 / 18.0)
    ]
}
