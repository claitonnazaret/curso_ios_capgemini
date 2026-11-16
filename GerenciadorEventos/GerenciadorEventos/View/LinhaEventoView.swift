//
//  LinhaEventoView.swift
//  GerenciadorEventos
//
//  Created by Nazaret, Claiton Milton Augusto on 14/11/26.
//

import SwiftUI

struct LinhaEventoView: View {
    let evento: Evento
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 6) {
            Text(evento.titulo)
                .font(.headline)
                .foregroundStyle(.primary)
            
            if !evento.descricao.isEmpty {
                Text(evento.descricao)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .lineLimit(2)
            }
            
            HStack(spacing: 12) {
                Label(
                    evento.dataHora.formatted(date: .abbreviated, time: .shortened),
                    systemImage: "calendar"
                )
                
                Label(evento.local, systemImage: "mappin.and.ellipse")
                    .lineLimit(1)
            }
            .font(.caption)
            .foregroundStyle(.blue)
            .padding(.top, 2)
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    LinhaEventoView(evento: Evento(titulo: "Teste", descricao: "Descricao teste", dataHora: .now, local: "Localidade teste"))
}

