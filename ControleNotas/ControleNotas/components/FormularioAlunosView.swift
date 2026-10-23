//
//  formulario.swift
//  ControleNotas
//
//  Created by Nazaret, Claiton Milton Augusto on 22/10/26.
//
import SwiftUI

struct FormularioAlunosView: View {
    
    @State private var nomeAluno: String = ""
    @State private var n1: String = ""
    @State private var n2: String = ""
    
    @State private var mensageErro: String = ""
    @State private var mostrarAlertaErro: Bool = false
    
    var onAdicionarAluno: (Aluno) -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            
            Text("Cadastrar Aluno")
                .font(.title3.bold())
                .foregroundStyle(.secondary)
            
            VStack(spacing: 12) {
                VStack(alignment: .leading, spacing: 4) {
                    Text("Nome").bold().foregroundStyle(.secondary)
                    TextField("Digite o nome do Aluno ", text: $nomeAluno)
                        .textFieldStyle(.roundedBorder)
                        .autocorrectionDisabled()
                }
                
                
                HStack(spacing: 12) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nota 1")
                            .bold()
                            .foregroundStyle(.secondary)
                        TextField("Digite a nota 1", text: $n1)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.decimalPad)
                    }
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text("Nota 2")
                            .bold()
                            .foregroundStyle(.secondary)
                        TextField("Digite a nota 2: ", text: $n2)
                            .textFieldStyle(.roundedBorder)
                            .keyboardType(.decimalPad)
                    }
                }
            }
            
            Button(action: cadastrarAluno) {
                HStack {
                    Spacer()
                    Image(systemName: "plus.circle.fill")
                    Text("Cadastrar Aluno")
                    Spacer()
                }
                .font(.body.bold())
                .foregroundStyle(.white)
                .padding(.vertical, 12)
                .background(.blue)
                .cornerRadius(8)
            }
        }
        .padding(.vertical, 12)
        .padding(.horizontal)
        .background(Color(uiColor: .secondarySystemGroupedBackground))
        .alert("Erro no Cadastro", isPresented: $mostrarAlertaErro) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(mensageErro)
        }
    }
    
    private func cadastrarAluno() {
        let n1Tratada = n1.replacingOccurrences(of: ",", with: ".")
        let n2Tratada = n2.replacingOccurrences(of: ",", with: ".")
        
        guard !nomeAluno.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            exibirErro(mensagem: "O nome do aluno não pode estar em branco.")
            return
        }
        
        guard let novaNota1 = Double(n1Tratada), let novaNota2 = Double(n2) else {
            exibirErro(mensagem: "As notas digitadas precisam ser números válidos")
            return
        }
        
        guard (0.0...10.0).contains(novaNota1)
                && (0.0...10.0).contains(novaNota2) else {
            exibirErro(mensagem: "As notas devem estar entra 0 e 10")
            return
        }
        let novoAluno = Aluno(nome: nomeAluno, nota1: novaNota1, nota2: novaNota2)
        
        onAdicionarAluno(novoAluno)
        
        limparCampos()
    }
    
    private func limparCampos() {
        nomeAluno = ""
        n1 = ""
        n2 = ""
    }
    
    private func exibirErro(mensagem: String) {
        mensageErro = mensagem
        mostrarAlertaErro = true
    }
}
