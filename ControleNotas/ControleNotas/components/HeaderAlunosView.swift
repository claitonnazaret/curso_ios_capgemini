//
//  HeaderAlunos.swift
//  ControleNotas
//
//  Created by Nazaret, Claiton Milton Augusto on 23/10/26.
//
import SwiftUI

struct HeaderAlunosView: View {
    
    var body: some View {
        VStack(spacing: 2) {
            Image(systemName: "graduationcap.circle")
                .font(.system(size: 40))
                .foregroundStyle(.white)
            
            Text("Minha Turma").font(.title).bold()
                .foregroundStyle(.white)
            
            Text("Cadastre alunos e acompanhe os resultados")
                .font(.subheadline)
                .foregroundStyle(.white)
            
        }.padding(.vertical, 1)
    }
}
