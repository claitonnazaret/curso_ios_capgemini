import SwiftUI
import SwiftData

@main struct GerenciadorEventos: App {
    
    let container: ModelContainer
    @State private var viewModel: EventoViewModel
    
    init() {
        do {
            let modelContainer = try ModelContainer(for: Evento.self)
            self.container = modelContainer
            self._viewModel = State(
                initialValue: EventoViewModel(modelContext: modelContainer.mainContext)
            )
        } catch {
            fatalError("Falha ao inicializar o ModelContainer do SwiftData: \(error)")
        }
    }
    
    var body: some Scene {
        WindowGroup {
            ListaEventoView(eventoViewModel: viewModel)
        }
        .modelContainer(container)
    }
}
