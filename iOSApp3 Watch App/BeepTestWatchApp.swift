import SwiftUI

@main
struct BeepTestWatchApp: App {
    @StateObject private var store = ResultsStore()
    @StateObject private var vm = RunViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                RootView()
                    .environmentObject(vm)
                    .environmentObject(store)
            }
        }
    }
}
