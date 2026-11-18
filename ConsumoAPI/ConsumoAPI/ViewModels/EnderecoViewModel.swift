//
//  EnderecoViewModel.swift
//  ConsumoAPI
//
//  Created by Nazaret, Claiton Milton Augusto on 18/11/26.
//
import Foundation
import SwiftData
import Observation

@Observable final class EnderecoViewModel {
    
    var cepInput: String = ""
    var resultadoBusca: ViaCEPResponse?
    var carregando: Bool = false
    var mensagemErro: String?
    
    private let service = ViaCEPService()
    
    @MainActor
    func pesquisaCEP() async {
        mensagemErro = nil
        resultadoBusca = nil
        carregando = true
        
        do {
            let resposta = try await service.buscarEndereco(por: cepInput)
            self.resultadoBusca = resposta
        } catch {
            self.mensagemErro = error.localizedDescription
        }
        
        carregando = false
    }
    
    @MainActor
    func salvarEndereco(context: ModelContext, listaAtual: [Endereco]) {
        guard let resultado = resultadoBusca, let cep = resultado.cep else { return }
        
        if listaAtual.contains(where: { $0.cep == cep }) {
            mensagemErro = "Este CEP já está salvo na sua lista."
            return
        }
        
        let novoEndereco = Endereco(
            cep: cep,
            logradouro: resultado.logradouro ?? "Sem logradouro",
            bairro: resultado.bairro ?? "Sem bairro",
            localidade: resultado.localidade ?? "Cidade desconhecida",
            uf: resultado.uf ?? "--"
        )
        
        context.insert(novoEndereco)
        try? context.save()

        resultadoBusca = nil
        cepInput = ""
    }
    
    @MainActor
    func removerEnderecos(offsets: IndexSet, listaAtual: [Endereco], context: ModelContext) {
        for index in offsets {
            let item = listaAtual[index]
            context.delete(item)
        }
        try? context.save()
    }
}
