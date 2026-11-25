//
//  RegisterView.swift
//  LoginExample
//
//  Created by Nazaret, Claiton Milton Augusto on 25/11/26.
//

import SwiftUI

struct RegisterView: View {
    
    @Bindable var viewModel: AuthViewModel
    @State private var isPasswordVisible = false
    @State private var isConfirmPasswordVisible = false
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
            
                VStack(spacing: 6) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 54))
                        .foregroundStyle(.blue)
                    Text("Criar Conta")
                        .font(.title.bold())
                    Text("Preencha os dados abaixo para começar")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                .padding(.top, 16)
                
                VStack(spacing: 14) {
                    TextField("Nome completo", text: $viewModel.registerName)
                        .textContentType(.name)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    TextField("E-mail", text: $viewModel.registerEmail)
                        .keyboardType(.emailAddress)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    
                    PasswordField("Senha", text: $viewModel.registerPassword)
                    
                    PasswordField("Confirmar Senha", text: $viewModel.registerConfirmPassword)
                    
                    if !viewModel.registerConfirmPassword.isEmpty &&
                        viewModel.registerPassword != viewModel.registerConfirmPassword {
                        Text("As senhas não coincidem.")
                            .font(.caption)
                            .foregroundStyle(.red)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                
                if let error = viewModel.errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                }
                
                Button {
                    Task { await viewModel.register() }
                } label: {
                    Group {
                        if viewModel.isLoading {
                            ProgressView().tint(.white)
                        } else {
                            Text("Finalizar Cadastro").fontWeight(.semibold)
                        }
                    }
                    .frame(maxWidth: .infinity).frame(height: 50)
                    .background(viewModel.isRegisterValid ? .blue : .gray.opacity(0.4))
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                }
                .disabled(!viewModel.isRegisterValid || viewModel.isLoading)
            }
            .padding(.horizontal, 20)
        }
        .navigationBarTitleDisplayMode(.inline)
        .onDisappear {
            viewModel.errorMessage = nil
        }
    }
}
