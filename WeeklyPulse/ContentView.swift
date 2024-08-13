import SwiftUI
import WeekNumberLibrary

struct ContentView: View {
    private let calculator = WeekNumberCalculator()

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()

                Text("Week Number: " + String(calculator.getWeekNumber(of: Date())))
                    .font(.system(size: geometry.size.width * 0.1, weight: .bold, design: .default))
                    .frame(width: geometry.size.width, height: geometry.size.height * 0.1)

                Spacer()

                VStack(alignment: .leading) {
                    ProgressView(value: calculator.getYearProgress(), total: 1.0)
                        .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                        .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.1) // Increased height for thicker progress bar
                        .padding(.bottom, 5) // Add padding if needed for spacing

                    Text(String(format: "%.1f%% (%d)", calculator.getYearProgress() * 100, Calendar.current.component(.year, from: Date())))
                        .font(.system(size: geometry.size.width * 0.05, weight: .bold))
                        .frame(width: geometry.size.width * 0.8)
                }
                .padding()

                ZStack(alignment: .leading) {
                    // TODO: fix visibility issue
                    Button("OK") {
                        NSApp.hide(nil)
                    }
                    .font(.system(size: geometry.size.width * 0.05, weight: .bold, design: .default))
                    .frame(width: geometry.size.width * 2, height: geometry.size.height * 0.3)

                    Spacer()

                    Button("Quit") {
                        NSApp.terminate(nil)
                    }
                    .font(.system(size: geometry.size.width * 0.05, weight: .bold, design: .default))
                    .frame(width: geometry.size.width * 2, height: geometry.size.height * 0.3)
                }
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    ContentView()
}
