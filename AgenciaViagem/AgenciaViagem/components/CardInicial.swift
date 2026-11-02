//
//  CardInicial.swift
//  AgenciaViagem
//
//  Created by Nazaret, Claiton Milton Augusto on 30/10/26.
//
import SwiftUI

struct CardInicial: View {
    
    var pacote: PacoteTuristico
    
    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Image(pacote.imagemNome)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 90, height: 90)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading, spacing: 4) {
                Text(pacote.titulo)
                    .font(.system(size: 18, weight: .bold))
                    .lineLimit(2)
                Text(pacote.local)
                    .font(.system(size: 14, weight: .bold))
                    .foregroundStyle(.gray)
                
                HStack(spacing: 4) {
                    Text("\(pacote.diarias) diárias - ")
                        .font(.system(size: 12, weight: .bold))
                    Text(pacote.preco, format: .currency(code: "BRL"))
                        .font(.system(size: 12, weight: .bold))
                }
                .foregroundStyle(.blue)
                .padding(.top, 4)
            }
        }
    }
}


