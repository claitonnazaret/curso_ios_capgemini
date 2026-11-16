//
//  CadastroEventoView.swift
//  GerenciadorEventos
//
//  Created by Nazaret, Claiton Milton Augusto on 14/11/26.
//

import SwiftUI

struct CadastroEventoView: View {
    
    @Environment(\.dismiss) private var fechar
    @Bindable var eventoViewModel: EventoViewModel
    
    var eventoParaEditar: Evento?
    
    @State private var titulo: String = ""
    @State private var descricao: String = ""
    @State private var dataHora: Date = Date()
    @State private var local: String = ""
    
    private var modoEdicao: Bool {
        eventoParaEditar != nil
    }
        
    var body: some View {
        NavigationStack {
            Form {
                Section("Informações Principais") {
                    TextField("Título do evento *", text: $titulo)
                    TextField("Local *", text: $local)
                    DatePicker(
                        "Data e Hora",
                        selection: $dataHora,
                        displayedComponents: [.date, .hourAndMinute]
                    )
                }
                
                Section("Detalhes") {
                    TextField(
                        "Descrição do evento",
                        text: $descricao,
                        axis: .vertical
                    )
                    .lineLimit(3...6)
                }
            }
            .navigationTitle("\(modoEdicao ? "Editar " : "Novo") Evento")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button {
                        fechar()
                    } label: {
                        Text("Cancelar")
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button{
                        let sucesso = eventoViewModel.salvarEvento(
                            eventoExistente: eventoParaEditar,
                            titulo: titulo,
                            descricao: descricao,
                            dataHora:dataHora,
                            local: local
                        )
                        if sucesso {
                            fechar()
                        }
                    } label: {
                        Text("Salvar")
                            .foregroundStyle(.blue)
                    }
                }
            }
            .alert("Campos obrigatórios", isPresented: $eventoViewModel.exibirAlertaValidacao) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(eventoViewModel.mensagemErro)
            }
            .onAppear {
                if let evento = eventoParaEditar {
                    titulo = evento.titulo
                    descricao = evento.descricao
                    dataHora = evento.dataHora
                    local = evento.local
                }
            }
        }
    }
}
