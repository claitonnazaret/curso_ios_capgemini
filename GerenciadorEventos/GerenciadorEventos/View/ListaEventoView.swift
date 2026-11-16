//
//  ListaEventoView.swift
//  GerenciadorEventos
//
//  Created by Nazaret, Claiton Milton Augusto on 14/11/26.
//

import SwiftUI

struct ListaEventoView: View {
        
    @Bindable var eventoViewModel: EventoViewModel
    
    @State private var exibirCadastroNovo = false
    @State private var eventoSelecionadoParaEdicao: Evento?
    
    var body: some View {
        NavigationStack {
            Group {
                if eventoViewModel.eventosFiltrados.isEmpty {
                    ContentUnavailableView(
                        eventoViewModel.textoBusca.isEmpty ? "Nenhum Evento" : "Sem Resultados",
                        systemImage: "calendar.badge.exclamationmark",
                        description: Text(
                            eventoViewModel.textoBusca.isEmpty
                            ? "Toque no botão + para cadastrar um novo evento."
                            : "Nenhum evento encontrado para \"\(eventoViewModel.textoBusca)\"."
                        )
                    )
                } else {
                    List {
                        ForEach(eventoViewModel.eventosFiltrados) { evento in
                            Button {
                                eventoSelecionadoParaEdicao = evento
                            } label: {
                                LinhaEventoView(evento: evento)
                            }
                            .buttonStyle(.plain)
                        }
                        .onDelete(perform: eventoViewModel.removerEventos)
                    }
                }
            }
            .navigationTitle("Meus Eventos")
            .searchable(text: $eventoViewModel.textoBusca, prompt: "Buscar por título / local")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        exibirCadastroNovo = true
                    } label: {
                        Image(systemName: "plus")
                    }
                    .accessibilityLabel("Adicionar Evento")
                }
            }
            .sheet(isPresented: $exibirCadastroNovo) {
                CadastroEventoView(eventoViewModel: eventoViewModel)
            }
            .sheet(item: $eventoSelecionadoParaEdicao) { evento in
                CadastroEventoView(eventoViewModel: eventoViewModel, eventoParaEditar: evento)
            }
        }
    }
}
