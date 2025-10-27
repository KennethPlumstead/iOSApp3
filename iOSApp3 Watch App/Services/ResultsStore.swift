import Foundation
import Combine
import SwiftUI

final class ResultsStore: ObservableObject {
    @Published private(set) var results: [RunResult] = []
    private let key = "beep.results"

    init() { load() }

    func add(_ result: RunResult) {
        results.insert(result, at: 0)
        save()
    }

    func delete(at offsets: IndexSet) {
        results.remove(atOffsets: offsets)
        save()
    }

    private func save() {
        if let data = try? JSONEncoder().encode(results) {
            UserDefaults.standard.set(data, forKey: key)
        }
    }

    private func load() {
        guard let data = UserDefaults.standard.data(forKey: key),
              let decoded = try? JSONDecoder().decode([RunResult].self, from: data) else { return }
        results = decoded
    }
}
