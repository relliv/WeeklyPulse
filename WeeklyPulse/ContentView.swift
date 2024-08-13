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
            }
            .padding()
            .frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

#Preview {
    ContentView()
}
