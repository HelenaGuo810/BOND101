import SwiftUI

@main
struct MyApp: App {
    @AppStorage("hasStarted") private var hasStarted = false

    // Debug hook so tooling/screenshots can jump straight to one screen.
    private static let debugScreen = ProcessInfo.processInfo.environment["BOND101_SCREEN"]

    var body: some Scene {
        WindowGroup {
            Group {
                switch Self.debugScreen {
                case "deck": MainShellView(initialTab: .deck)
                case "community": MainShellView(initialTab: .community)
                case "connections": MainShellView(initialTab: .account)
                case "entry": EntryDetailView()
                case "blue": BlueEntryDetailView()
                case "new": NewEntryView()
                default: root
                }
            }
            .preferredColorScheme(.dark)
        }
    }

    @ViewBuilder
    private var root: some View {
        if hasStarted {
            MainShellView()
                .transition(.opacity)
        } else {
            WelcomeView {
                withAnimation(.easeInOut(duration: 0.4)) { hasStarted = true }
            }
        }
    }
}
