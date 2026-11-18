//
//  ViaCepResponse.swift
//  ConsumoAPI
//
//  Created by Nazaret, Claiton Milton Augusto on 18/11/26.
//

import Foundation

struct ViaCEPResponse: Codable {
    let cep: String?
    let logradouro: String?
    let complemento: String?
    let bairro: String?
    let localidade: String?
    let uf: String?
    let erro: Bool?
}
