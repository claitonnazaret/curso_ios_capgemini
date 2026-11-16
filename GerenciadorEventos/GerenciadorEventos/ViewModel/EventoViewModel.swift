//
//  EventoViewModel.swift
//  GerenciadorEventos
//
//  Created by Nazaret, Claiton Milton Augusto on 14/11/26.
//

import Foundation
import SwiftData
import Observation

@Observable
final class EventoViewModel {
    private var modelContext: ModelContext
    
    var eventos: [Evento] = []
    var textoBusca: String = ""
    
    var exibirAlertaValidacao: Bool = false
    var mensagemErro = ""
    
    var eventosFiltrados: [Evento] {
        let termo = textoBusca.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if termo.isEmpty {
            return eventos
        }
        
        return eventos.filter { evento in
            evento.titulo.localizedCaseInsensitiveContains(termo)
            || evento.local.localizedCaseInsensitiveContains(termo)
        }
    }
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        buscarEventos()
    }
    
    func buscarEventos() {
        do {
            let descritor = FetchDescriptor<Evento>(
                sortBy: [SortDescriptor(\.dataHora, order: .forward)]
            )
            eventos = try modelContext.fetch(descritor)
        } catch {
            print("Erro ao buscar eventos: \(error.localizedDescription)")
        }
    }
    
    func salvarEvento(
        eventoExistente: Evento? = nil,
        titulo: String,
        descricao: String,
        dataHora: Date,
        local: String
    ) -> Bool {
        let tituloFormatado = normalizeString(text: titulo)
        let localFormatado = normalizeString(text: local)
        let descricaoFormatado = normalizeString(text: descricao)
        
        guard validarCampos(titulo: tituloFormatado, local: localFormatado) else {
            return false
        }
        
        if let evento = eventoExistente {
            evento.titulo = tituloFormatado
            evento.descricao = descricaoFormatado
            evento.local = localFormatado
            evento.dataHora = dataHora
        } else {
            let novoEvento = Evento(
                titulo: tituloFormatado,
                descricao: descricaoFormatado,
                dataHora: dataHora,
                local: localFormatado
            )
            modelContext.insert(novoEvento)
        }
        
        salvarContexto()
        buscarEventos()
        return true
    }
    
    func removerEventos(at offsets: IndexSet) {
        for index in offsets {
            let eventoParaRemover = eventosFiltrados[index]
            modelContext.delete(eventoParaRemover)
        }
        salvarContexto()
        buscarEventos()
    }
    
    private func validarCampos(titulo: String, local: String) -> Bool {
        if titulo.isEmpty {
            mensagemErro = "O título do evento é obrigatório."
            exibirAlertaValidacao = true
            return false
        }
        
        if local.isEmpty {
            mensagemErro = "O local do evento é obrigatório."
            exibirAlertaValidacao = true
            return false
        }
        return true
    }
    
    private func salvarContexto() {
        do {
            try modelContext.save()
        } catch {
            print("Erro ao salvar contexto: \(error.localizedDescription)")
        }
    }
    
    private func normalizeString(text: String) -> String {
        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
