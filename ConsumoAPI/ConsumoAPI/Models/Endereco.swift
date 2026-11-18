//
//  Endereco.swift
//  ConsumoAPI
//
//  Created by Nazaret, Claiton Milton Augusto on 18/11/26.
//

import Foundation
import SwiftData

@Model final class Endereco {
    
    @Attribute(.unique) var cep: String
    var logradouro: String
    var bairro: String
    var localidade: String
    var uf: String
    var dataCriacao: Date
    
    init(cep: String, logradouro: String, bairro: String, localidade: String, uf: String) {
        self.cep = cep
        self.logradouro = logradouro
        self.bairro = bairro
        self.localidade = localidade
        self.uf = uf
        self.dataCriacao = Date()
    }
}
