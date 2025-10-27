import SwiftUI

struct StartView: View {
    @EnvironmentObject var vm: RunViewModel

    var body: some View {
        VStack(spacing: 10) {
            Text("Beep Test")
                .font(.title2).bold()

            Text("20 m shuttles • pace increases each level")
                .font(.footnote)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            Button("Start Test") { vm.start() }
                .buttonStyle(.borderedProminent)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            NavigationLink("History") { HistoryView() }
                .buttonStyle(.bordered)
                .clipShape(RoundedRectangle(cornerRadius: 12))

            Spacer(minLength: 6)
        }
        .padding()
    }
}

#if DEBUG
struct StartView_Previews: PreviewProvider {
    static var previews: some View {
        StartView()
            .environmentObject(RunViewModel())
            .environmentObject(ResultsStore())
            .previewDevice(PreviewDevice(rawValue: "Apple Watch Series 9 (45mm)"))
    }
}
#endif
