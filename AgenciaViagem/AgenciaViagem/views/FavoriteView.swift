//
//  FavoriteView.swift
//  AgenciaViagem
//
//  Created by Nazaret, Claiton Milton Augusto on 29/10/26.
//
import SwiftUI

struct FavoriteView: View {
    
    var pacotesFavoritos: [PacoteTuristico]
    
    var body: some View {
        NavigationStack {
            List(pacotesFavoritos) { pacote in
                
                HStack(alignment: .center, spacing: 8) {
                    NavigationLink(destination: DetailsView(pacote: pacote, isFavorito: true)) {
                        CardInicial(pacote: pacote)
                    }
                    
                    Spacer()
                    
                    Image(systemName: "heart.fill")
                        .foregroundStyle(.red)
                }
                
            }
        }
        .navigationTitle("Meus Favoritos")
    }
}
