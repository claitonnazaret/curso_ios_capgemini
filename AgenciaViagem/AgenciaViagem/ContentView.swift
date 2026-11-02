import SwiftUI

struct ContentView: View {
    
    @StateObject private var store = PacoteTuristicoStore()
    
    func isFavorito(id: UUID) -> Bool {
        return store.isFavorito(id: id)
    }
    
    var body: some View {
        
        NavigationStack {
            List(store.pacotes) { pacote in
                
                HStack(alignment: .center, spacing: 8) {
                    NavigationLink(destination: DetailsView(pacote: pacote, isFavorito: isFavorito(id: pacote.id))) {
                        CardInicial(pacote: pacote)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        store.toggleFavorito(pacote: pacote)
                    }) {
                        Image(systemName: isFavorito(id: pacote.id) ? "heart.fill" : "heart")
                            .foregroundStyle(isFavorito(id: pacote.id) ? .red : .gray.opacity( 0.7))
                    }
                }
                
              
            }
            .navigationTitle("Explorar Viagens")
            .navigationBarItems(trailing: FavoriteCount(favoritos: store.pacotesFavoritos))
        }
    }
}

#Preview {
    ContentView()
}
