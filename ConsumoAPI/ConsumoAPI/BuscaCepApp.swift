import SwiftUI
import SwiftData

@main struct BuscaCepApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Endereco.self)
    }
}
