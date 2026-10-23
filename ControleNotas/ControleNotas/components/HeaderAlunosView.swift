//
//  HeaderAlunos.swift
//  ControleNotas
//
//  Created by Nazaret, Claiton Milton Augusto on 23/10/26.
//
import SwiftUI

struct HeaderAlunos: View {
    
    var body: some View {
        VStack {
            Image(systemName: "graduationcap.circle")
                .font(.system(size: 60))
                .colorInvert()
            Text("Minha Turma").font(.largeTitle).bold()
                .colorInvert()
            Text("Cadastre alunos e acompanhe os resultados")
                .font(.caption)
                .colorInvert()
        }.padding(.bottom, 10)
        
    }
}
