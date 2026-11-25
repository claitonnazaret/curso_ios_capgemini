//
//  LoginView.swift
//  LoginExample
//
//  Created by Nazaret, Claiton Milton Augusto on 25/11/26.
//

import SwiftUI
import AuthenticationServices

struct LoginView: View {
    
    @Bindable var viewModel: AuthViewModel
    @State private var showRegister = false
    @State private var isPasswordVisible = false
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 22) {
                    VStack(spacing: 8) {
                        Image(systemName: "lock.shield.fill")
                            .font(.system(size: 54))
                            .foregroundStyle(.blue)
                        
                        Text("Bem-vindo de volta")
                            .font(.title.bold())
                        
                        Text("Entre na sua conta para continuar")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                    }
                    .padding(.top, 20)
                    
                    VStack(spacing: 14) {
                        TextField("E-mail", text: $viewModel.loginEmail)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                            .autocorrectionDisabled()
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        PasswordField("Senha", text: $viewModel.loginPassword)
                    }
                    
                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(.footnote)
                            .foregroundStyle(.red)
                            .multilineTextAlignment(.center)
                    }
                    
                    Button {
                        Task { await viewModel.login() }
                    } label: {
                        Group {
                            if viewModel.isLoading {
                                ProgressView().tint(.white)
                            } else {
                                Text("Entrar").fontWeight(.semibold)
                            }
                        }
                        .frame(maxWidth: .infinity).frame(height: 50)
                        .background(viewModel.isLoginValid ? .blue : .red)
                        .foregroundStyle(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .disabled(!viewModel.isLoginValid || viewModel.isLoading)
                    
                    HStack {
                        Rectangle().frame(height: 1).foregroundStyle(.quaternary)
                        Text("ou continue com")
                            .font(.footnote)
                            .foregroundStyle(.secondary)
                        Rectangle().frame(height: 1).foregroundStyle(.quaternary)
                    }
                    
                    VStack(spacing: 12) {
                        SignInWithAppleButton(.signIn) { request in
                            request.requestedScopes = [.fullName, .email]
                        } onCompletion: { result in
                            viewModel.handleAppleSignIn(result: result)
                        }
                        .signInWithAppleButtonStyle(colorScheme == .dark ? .white : .black)
                        .frame(height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                        
                        Button {
                            Task { await viewModel.loginWithGoogle() }
                        } label: {
                            HStack(spacing: 10) {
                                Image(systemName: "g.circle.fill")
                                    .font(.title3)
                                Text("Continuar com google")
                                    .fontWeight(.semibold)
                            }
                            .frame(maxWidth: .infinity).frame(height: 50)
                            .background(Color(.systemBackground))
                            .foregroundStyle(.primary)
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(.gray.opacity(0.3), lineWidth: 1)
                            )
                        }
                    }
                    
                    HStack(spacing: 4) {
                        Text("Não tem uma conta?")
                            .foregroundStyle(.secondary)
                        Button("Cadastre-se") {
                            viewModel.clearForms()
                            showRegister = true
                        }
                        .fontWeight(.semibold)
                    }
                    .font(.footnote)
                    .padding(.top, 8)
                }
                .padding(.horizontal, 24)
            }
            .navigationDestination(isPresented: $showRegister) {
                RegisterView(viewModel: viewModel)
            }
        }
    }
}
