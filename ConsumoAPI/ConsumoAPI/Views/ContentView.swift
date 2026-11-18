//
//  ContentView.swift
//  ConsumoAPI
//
//  Created by Nazaret, Claiton Milton Augusto on 18/11/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    
    @Environment(\.modelContext)
    private var modelContext
    
    @Query(sort: \Endereco.dataCriacao, order: .reverse)
    private var enderecos: [Endereco]
    
    @State private var viewModel = EnderecoViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                // Seçao 1:  Consulta á API Viacep
                Section("Consulta CEP") {
                    HStack {
                        TextField("Digite o CEP (ex: 88132000)", text: $viewModel.cepInput)
                            .keyboardType(.numberPad)
                        
                        Button("Buscar") {
                            Task {
                                await viewModel.pesquisaCEP()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .disabled(viewModel.cepInput.isEmpty || viewModel.carregando)
                    }
                    
                    if viewModel.carregando {
                        HStack {
                            Spacer()
                            ProgressView("Consultado ViaCEP...")
                            Spacer()
                        }
                    }
                    
                    if let erro = viewModel.mensagemErro {
                        Text(erro)
                            .foregroundStyle(.red)
                            .font(.footnote)
                    }
                }
                // Seçao 2:  Resultado da API & Cadastro Local
                if let resultado = viewModel.resultadoBusca {
                    Section("Resultado ENcontrado") {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(resultado.logradouro ?? "Logradouro não informado")
                                .font(.headline)
                            Text("\(resultado.bairro ?? "-") - \(resultado.localidade ?? "-")/\(resultado.uf ?? "-")")
                                .font(.subheadline)
                                .foregroundStyle(.secondary)
                            Text("CEP: \(resultado.cep ?? "-")")
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        .padding(.vertical, 4)
                        
                        Button {
                            viewModel.salvarEndereco(context: modelContext, listaAtual: enderecos)
                        } label: {
                            Label("Salvar nos Favoritos", systemImage: "bookmark")
                                .frame(maxWidth: .infinity)
                                .foregroundStyle(.green)
                                .fontWeight(.bold)
                        }
                        .buttonStyle(.bordered)
                        .tint(.green)
                    }
                }
                // Seçao 3: Listagem Persistida & Exclusão
                Section("Endereços Salvos (\(enderecos.count))") {
                    if enderecos.isEmpty {
                        ContentUnavailableView("Nenhum endereço salvo", systemImage: "mappin.slash", description: Text("Busque um CEP acima e salve para visualiza-lo aqui.").font(.caption))
                    } else {
                        ForEach(enderecos) { endereco in
                            VStack(alignment: .leading, spacing: 4) {
                                HStack {
                                    Text(endereco.cep)
                                        .font(.headline)
                                        .fontWeight(.bold)
                                    Spacer()
                                    Text("\(endereco.localidade) - \(endereco.uf)")
                                        .font(.caption)
                                        .padding(.horizontal, 8)
                                        .padding(.vertical, 2)
                                        .background(Color.blue.opacity(0.15))
                                        .clipShape(Capsule())
                                }
                                
                                Text(endereco.logradouro)
                                    .font(.subheadline)
                                Text("Bairro: \(endereco.bairro)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete { offsets in
                            viewModel.removerEnderecos(offsets: offsets, listaAtual: enderecos, context: modelContext)
                        }
                    }
                }
            }
            .navigationTitle("Busca CEP")
            .toolbar {
                if !enderecos.isEmpty {
                    EditButton()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
