//
//  tabela.swift
//  ControleNotas
//
//  Created by Nazaret, Claiton Milton Augusto on 22/10/26.
//

import SwiftUI

struct TabelaAlunosView: View {
    
    @State private var alunoSelecionado: Aluno? = nil
    @State private var exibirAlerta: Bool = false
    
    var alunos: [Aluno]
    
    var onRemoverAluno: (UUID) -> Void
    
    let colunas: [GridItem] = [
        GridItem(.flexible(minimum: 130), spacing: 8, alignment: .leading),
        GridItem(.fixed(60), spacing: 8, alignment: .center),
        GridItem(.fixed(60), spacing: 8, alignment: .center),
        GridItem(.fixed(60), spacing: 8, alignment: .center),
        GridItem(.fixed(100), spacing: 8, alignment: .center),
        GridItem(.fixed(50), spacing: 8, alignment: .center)
    ]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Lista de Alunos")
                .font(.title3.bold())
                .foregroundStyle(.secondary)
            
            ScrollView(.horizontal, showsIndicators: true) {
                ScrollView(.vertical, showsIndicators: true) {
                    LazyVGrid(columns: colunas, spacing: 0) {
                        
                        Text("Nome").bold().foregroundStyle(.secondary)
                        Text("Nota 1").bold().foregroundStyle(.secondary)
                        Text("Nota 2").bold().foregroundStyle(.secondary)
                        Text("Média").bold().foregroundStyle(.secondary)
                        Text("Situação").bold().foregroundStyle(.secondary)
                        Text("Ação").bold().foregroundStyle(.secondary)
                        
                    }
                    
                    Divider().background(Color.gray.opacity(0.4))
            
            if alunos.isEmpty {
                HStack {
                    Spacer()
                    Text("Nenhum aluno cadastrado")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        .italic()
                        .padding(.vertical, 20)
                    Spacer()
                }
            } else {
                
                        
                        LazyVGrid(columns: colunas, spacing: 16) {
                            ForEach(alunos) {aluno in
                                
                                Text(aluno.nome).font(.subheadline)
                                Text(String(format: "%.1f", aluno.nota1)).font(.subheadline)
                                Text(String(format: "%.1f", aluno.nota2)).font(.subheadline)
                                Text(String(format: "%.1f", aluno.media)).font(.subheadline)
                                Text(aluno.situacao)
                                    .font(.subheadline)
                                    .foregroundStyle(aluno.isAprovado ? .green : .red)
                                    .bold()
                                
                                Button(action: {
                                    alunoSelecionado = aluno
                                    exibirAlerta = true
                                }) {
                                    Image(systemName: "trash").foregroundStyle(.red).font(.body)
                                }
                                
                            }
                        }.padding(.vertical)
                    }
                }
            }
        }
        .padding(.vertical, 8)
        .padding(.bottom, 50)
        .padding(.horizontal)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .alert(String("Atenção"), isPresented: $exibirAlerta) {
            Button("Remover", role: .destructive) {
                if let aluno = alunoSelecionado {
                    removerAluno(id: aluno.id)
                }
            }
            Button("Cancelar", role: .cancel) {
                alunoSelecionado = nil
            }
        } message: {
            Text("Tem certeza que deseja remover o(a) aluno(a) \(alunoSelecionado?.nome ?? "") do controle?")
        }
    }
    
    private func removerAluno(id: UUID) {
        withAnimation(.easeInOut(duration: 0.25)) {
            onRemoverAluno(id)
        }
    }
}

#Preview {
    ContentView()
}


