//
//  Evento.swift
//  GerenciadorEventos
//
//  Created by Nazaret, Claiton Milton Augusto on 14/11/26.
//

import Foundation
import SwiftData

@Model
final class Evento {
    var titulo: String
    var descricao: String
    var dataHora: Date
    var local: String
    
    init(titulo: String, descricao: String, dataHora: Date, local: String) {
        self.titulo = titulo
        self.descricao = descricao
        self.dataHora = dataHora
        self.local = local
    }
}
