//
//  Aluno.swift
//  ControleNotas
//
//  Created by Nazaret, Claiton Milton Augusto on 22/10/26.
//

import SwiftUI

struct Aluno: Identifiable {
    let id = UUID()
    var nome: String
    var nota1: Double
    var nota2: Double
    
    var media: Double {
        return (nota1 + nota2) / 2
    }
    
    var isAprovado: Bool {
        return media >= 7.0
    }
    
    var situacao: String {
        return isAprovado ? "Aprovado" : "Reprovado"
    }
}
