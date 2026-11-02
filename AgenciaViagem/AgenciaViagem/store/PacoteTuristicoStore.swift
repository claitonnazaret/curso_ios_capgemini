//
//  PacoteTuristicoStore.swift
//  AgenciaViagem
//
//  Created by Nazaret, Claiton Milton Augusto on 02/11/26.
//
import Foundation
import Combine

class PacoteTuristicoStore: ObservableObject {
    
    @Published var pacotes: [PacoteTuristico] = [
        PacoteTuristico(
            titulo: "Praça dos 3 Poderes",
            local: "Brasília/DF",
            diarias: 7,
            dataPartida: "10/12/2026",
            dataChegada: "17/12/2026",
            informacoesHotel: "Conheça a praça dos 3 poderes em Brasília",
            imagemNome: "brasilia",
            preco: 675.90
        ),
        PacoteTuristico(
            titulo: "Canyon de Furnas",
            local: "Capitólio/MG",
            diarias: 4,
            dataPartida: "15/01/2027",
            dataChegada: "19/01/2027",
            informacoesHotel: "Explore os impressionantes canyons e cachoeiras de Capitólio",
            imagemNome: "capitolio",
            preco: 890.00
        ),
        PacoteTuristico(
            titulo: "Jardim Botânico",
            local: "Curitiba/PR",
            diarias: 5,
            dataPartida: "20/02/2027",
            dataChegada: "25/02/2027",
            informacoesHotel: "Visite a famosa estufa de vidro e os jardins franceses de Curitiba",
            imagemNome: "curitiba",
            preco: 550.50
        ),
        PacoteTuristico(
            titulo: "Praia da Joaquina",
            local: "Florianópolis/SC",
            diarias: 7,
            dataPartida: "05/03/2027",
            dataChegada: "12/03/2027",
            informacoesHotel: "Curta as dunas e o mar cristalino de Florianópolis",
            imagemNome: "florianopolis",
            preco: 1200.00
        ),
        PacoteTuristico(
            titulo: "Circuito Lagoa Azul",
            local: "Lençóis Maranhenses/MG",
            diarias: 6,
            dataPartida: "12/06/2027",
            dataChegada: "18/06/2027",
            informacoesHotel: "Descubra as lagoas paradisíacas em meio às dunas dos Lençóis Maranhenses",
            imagemNome: "lencois",
            preco: 1450.75
        )
    ]
    
    @Published var favoritosIds: Set<UUID> = []
    
    var pacotesFavoritos: [PacoteTuristico] {
        pacotes.filter { favoritosIds.contains($0.id)}
    }
    
    func toggleFavorito(pacote: PacoteTuristico) {
        if favoritosIds.contains(pacote.id) {
            favoritosIds.remove(pacote.id)
        } else {
            favoritosIds.insert(pacote.id)
        }
    }
    
    func isFavorito(id: UUID) -> Bool {
        return favoritosIds.contains(id)
    }
}
