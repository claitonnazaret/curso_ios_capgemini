//
//  formulario.swift
//  ControleNotas
//
//  Created by Nazaret, Claiton Milton Augusto on 22/10/26.
//
import SwiftUI

struct Formulario: View {
    
    @State private var nomeAluno: String = ""
    @State private var n1: String = ""
    @State private var n2: String = ""
    
    var onAdicionarAluno: (Aluno) -> Void
    
    var body: some View {
        Form{
            Section(header: Text("Cadastro do Aluno")) {
                TextField("Nome: ", text: $nomeAluno)
                
                TextField("Nota 1: ", text: $n1).keyboardType(.decimalPad)
                
                TextField("Nota 2: ", text: $n2)
                    .keyboardType(.decimalPad)
                
                Button(action: cadastrarAluno) {
                    Text("Adicionar Aluno")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .bold()
                }
                .disabled(nomeAluno.isEmpty || n1.isEmpty || n2.isEmpty)
                
            }
        }
    }
    
    private func cadastrarAluno() {
        let novaNota1 = Double(n1) ?? 0.0
        let novaNota2 = Double(n2) ?? 0.0
        
        let novoAluno = Aluno(nome: nomeAluno, nota1: novaNota1, nota2: novaNota2)
        
        onAdicionarAluno(novoAluno)
        
        nomeAluno = ""
        n1 = ""
        n2 = ""
    }
}

#Preview {
    ContentView()
}


