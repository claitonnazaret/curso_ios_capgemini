//
//  FavoriteCount.swift
//  AgenciaViagem
//
//  Created by Nazaret, Claiton Milton Augusto on 02/11/26.
//
import SwiftUI

struct FavoriteCount: View {
    
    var favoritos: [PacoteTuristico] = []
    
    
    var body: some View {
        NavigationLink(destination: FavoriteView(pacotesFavoritos: favoritos)) {
        
            HStack(alignment: .center, spacing: 4) {
                Image( systemName: "heart.fill")
                    .foregroundStyle(.red)
                if favoritos.count > 0 {
                    Text("\(favoritos.count)")
                        .font(.headline.bold())
                        .foregroundStyle(.black)
                }
            }.padding(.horizontal, 10)
        }
        
    }
}

