import SwiftUI

struct HistoryView: View {
    @EnvironmentObject var store: ResultsStore

    var body: some View {
        List {
            ForEach(store.results) { r in
                HStack {
                    VStack(alignment: .leading, spacing: 2) {
                        Text("Level \(r.level).\(r.shuttle)").font(.headline)
                        Text(r.date, style: .date)
                            .font(.caption2)
                            .foregroundStyle(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 2) {
                        Text("\(r.totalShuttles) shuttles").font(.footnote)
                        Text("\(r.durationSeconds)s")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                .padding(.vertical, 2)
            }
            .onDelete(perform: store.delete)
        }
        .navigationTitle("History")
    }
}

#if DEBUG
struct HistoryView_Previews: PreviewProvider {
    static var previews: some View {
        let store = ResultsStore()
        // seed a couple of rows for preview
        store.add(RunResult(level: 6, shuttle: 3, totalShuttles: 45, durationSeconds: 260))
        store.add(RunResult(level: 9, shuttle: 2, totalShuttles: 72, durationSeconds: 420))
        return HistoryView()
            .environmentObject(store)
            .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 9 (45mm)"))
    }
}
#endif
