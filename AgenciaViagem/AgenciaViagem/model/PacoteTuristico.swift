//
//  PacoteTuristico.swift
//  AgenciaViagem
//
//  Created by Nazaret, Claiton Milton Augusto on 29/10/26.
//
import SwiftUI

struct PacoteTuristico: Identifiable {
    let id = UUID()
    let titulo: String
    let local: String
    let diarias: Int
    let dataPartida: String
    let dataChegada: String
    let informacoesHotel: String
    let imagemNome: String
    let preco: Double
}
