//
//  tabela.swift
//  ControleNotas
//
//  Created by Nazaret, Claiton Milton Augusto on 22/10/26.
//

import SwiftUI

struct TabelaAlunosView: View {
    var alunos: [Aluno]
    
    let colunas: [GridItem] = [
        GridItem(.flexible(minimum: 100), spacing: 8),
        GridItem(.flexible(minimum: 50), spacing: 8),
        GridItem(.flexible(minimum: 50), spacing: 8),
        GridItem(.flexible(minimum: 50), spacing: 8),
        GridItem(.flexible(minimum: 50), spacing: 8)
    ]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            Text("Lista de Alunos")
                .font(.title2)
                .padding([.top, .leading])
            
            ScrollView(.vertical, showsIndicators: true) {
                LazyVGrid(columns: colunas, alignment: .leading, spacing: 12, pinnedViews: .sectionHeaders) {
                    
                    Section(header: cabecalho) {
                        
                        ForEach(alunos) {aluno in
                        
                            Text(aluno.nome).font(.subheadline).lineLimit(1)
                            Text(String(format: "%.1f", aluno.nota1)).font(.subheadline)
                            Text(String(format: "%.1f", aluno.nota2)).font(.subheadline)
                            Text(String(format: "%.1f", aluno.media)).font(.subheadline)
                            Text(aluno.situacao)
                                .font(.caption)
                                .bold()
                            
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    private var cabecalho: some View {
        Group {
            Text("Nome").bold()
            Text("Nota 1").bold()
            Text("Nota 2").bold()
            Text("Média").bold()
            Text("Situação").bold()
        }
        .font(.footnote)
        .foregroundStyle(.gray)
        .padding(.vertical, 8)
        .background(Color(UIColor.systemBackground))
    }
}

#Preview {
    ContentView()
}
