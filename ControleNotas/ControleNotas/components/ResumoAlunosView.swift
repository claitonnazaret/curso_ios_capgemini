//
//  ResumoAlunosView.swift
//  ControleNotas
//
//  Created by Nazaret, Claiton Milton Augusto on 23/10/26.
//
import SwiftUI

struct ResumoAlunosView: View {
    
    var totalAlunos: Int = 0
    var totalAlunosAprovados: Int = 0
    var totalAlunosReprovados: Int = 0
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 12) {
            Text("Resumo da Turma")
                .font(.title3.bold())
                .foregroundStyle(.secondary)
            
            HStack {
                CardResumo(
                    titulo: "Total",
                    valor: "\(totalAlunos)",
                    icon: "person.3.fill",
                    cor: .cyan)
                Spacer()
                CardResumo(
                    titulo: "Aprovados",
                    valor: "\(totalAlunosAprovados)",
                    icon: "checkmark.circle.fill",
                    cor: .green)
                Spacer()
                CardResumo(
                    titulo: "Reprovados",
                    valor: "\(totalAlunosReprovados)",
                    icon: "xmark.circle.fill",
                    cor: .red)
            }
        }
        .padding(.vertical, 4)
        .padding(.horizontal)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
    }
}

struct CardResumo: View {
    let titulo: String
    let valor: String
    let icon: String
    let cor: Color
    
    var body: some View {
        VStack(alignment: .center, spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 25))
                .foregroundStyle(cor)
            Text(String(valor))
                .font(.title2.bold())
                .foregroundStyle(cor)
            Text(titulo)
                .font(.subheadline)
                .foregroundStyle(.gray)
                .bold()
        }
        .padding(.horizontal)
        .padding(.vertical, 8)
    }
}

