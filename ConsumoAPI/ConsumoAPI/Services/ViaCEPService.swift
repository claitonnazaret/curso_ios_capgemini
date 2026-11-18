//
//  ViaCEPService.swift
//  ConsumoAPI
//
//  Created by Nazaret, Claiton Milton Augusto on 18/11/26.
//

import Foundation

final class ViaCEPService {
    
    func urlViaCep(cep: String) -> String {
        return "https://viacep.com.br/ws/\(cep)/json/"
    }
    
    func buscarEndereco(por cep: String) async throws -> ViaCEPResponse {
        
        let cepLimpo = cep.filter { $0.isNumber }
        
        guard cepLimpo.count == 8 else {
            throw APIError.cepInvalido
        }
        
        guard let url = URL(string: urlViaCep(cep: cepLimpo)) else {
            throw APIError.urlInvalido
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw APIError.falhaNaRequisicao
        }
        
        let endereco = try JSONDecoder().decode(ViaCEPResponse.self, from: data)
        
        if endereco.erro == true || endereco.cep == nil {
            throw APIError.cepNaoEncontrado
        }
        
        return endereco
    }
}
