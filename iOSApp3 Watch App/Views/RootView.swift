//
//  SwiftUIView.swift
//  iOSApp3 Watch App
//
//  Created by Kenneth Plumstead on 2025-10-26.
//

import SwiftUI

/// Central router: shows exactly ONE screen at a time based on the view model phase.
struct RootView: View {
    @EnvironmentObject var vm: RunViewModel
    @EnvironmentObject var store: ResultsStore

    var body: some View {
        Group {
            switch vm.phase {
            case .idle:
                StartView()
            case .countdown:
                CountdownView()
            case .running:
                RunView()
            case .finished:
                SummaryView()
            }
        }
        .animation(.easeInOut(duration: 0.25), value: phaseKey)
        .transition(.opacity)
    }

    private var phaseKey: String {
        switch vm.phase {
        case .idle: return "idle"
        case .countdown(let n): return "cd\(n)"
        case .running: return "run"
        case .finished: return "done"
        }
    }
}

#if DEBUG
struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = RunViewModel()
        let store = ResultsStore()
        return RootView()
            .environmentObject(vm)
            .environmentObject(store)
            .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 9 (45mm)"))
            .previewDisplayName("Root (Idle)")
    }
}
#endif
