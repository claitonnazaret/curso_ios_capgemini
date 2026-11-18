//
//  ApiError.swift
//  ConsumoAPI
//
//  Created by Nazaret, Claiton Milton Augusto on 18/11/26.
//
import Foundation

enum APIError: LocalizedError {
    case cepInvalido
    case urlInvalido
    case falhaNaRequisicao
    case cepNaoEncontrado
    
    var errorDescription: String? {
        switch self {
        case .cepInvalido:
            return "O CEP deve conter exatamente 8 dígidos numéricos."
        case .urlInvalido:
            return "Erro ao contruir o endereço da requisição."
        case .falhaNaRequisicao:
            return "Não foi possivel conectar ao servidor do ViaCEP."
        case .cepNaoEncontrado:
            return "CEP não encontrado na base de dados."
            
        }
    }
}
