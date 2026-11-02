//
//  DetalhesView.swift
//  AgenciaViagem
//
//  Created by Nazaret, Claiton Milton Augusto on 29/10/26.
//
import SwiftUI

struct DetailsView: View {
    
    var pacote: PacoteTuristico
    var isFavorito: Bool
    
    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            
            HStack {
                Text("Detalhes do Pacote")
                    .font(.title.bold())
                    .foregroundStyle(.black)
                
            }
            .padding(.horizontal)
            .padding(.top, 10)
            ScrollView(showsIndicators: false) {
                
                VStack(alignment: .leading, spacing: 20){
                    
                    ZStack(alignment: .center) {
                        Image(pacote.imagemNome)
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(maxHeight: 200)
                            .padding(24)
                            .background(Color(.systemGray6))
                            .clipShape(RoundedRectangle(cornerRadius: 24))
                        Image(systemName: isFavorito ? "heart.fill" : "heart")
                            .foregroundStyle(isFavorito ? .red : .gray.opacity( 0.7))
                            .font(.title)
                            .padding(16)
                            .background(.white.opacity(0.6))
                            .clipShape(Circle())
                    }
                    .padding(.top, 10)
                    
                    VStack(alignment: .leading, spacing: 6) {
                        Text(pacote.local)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.blue)
                        Text(pacote.titulo)
                            .font(.title.bold())
                            .foregroundStyle(.black)
                        
                    }
                    
                    Divider().padding(.vertical, 5)
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Partida")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Text(pacote.dataPartida)
                                .font(.body.bold())
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Diárias")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Text("\(pacote.diarias) dias")
                                .font(.body.bold())
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Chegada")
                                .font(.caption)
                                .foregroundStyle(.gray)
                            Text(pacote.dataChegada)
                                .font(.body.bold())
                        }
                    }
                    
                    Divider().padding(.vertical, 5)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Informações")
                            .font(.headline.bold())
                            .foregroundStyle(.black)
                        Text(pacote.informacoesHotel)
                            .font(.body)
                            .foregroundStyle(.gray)
                            .lineSpacing(4)
                    }
                    
                    Spacer()
                    
                    Button(action: {
                        
                    }) {
                        Text("Reservar por \(pacote.preco.formatted(.currency(code: "BRL")))")
                            .font(.headline)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, minHeight: 35)
                            .padding(.vertical, 16)
                            .background(.blue)
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}
