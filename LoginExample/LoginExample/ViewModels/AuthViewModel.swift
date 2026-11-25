//
//  AuthViewModel.swift
//  LoginExample
//
//  Created by Nazaret, Claiton Milton Augusto on 25/11/26.
//

import SwiftUI
import SwiftData
import AuthenticationServices

@Observable
@MainActor final class AuthViewModel {
    
    var currentUser: UserEntity?
    var isInitializing = true
    var isLoading = false
    var errorMessage: String?
    
    var loginEmail = ""
    var loginPassword = ""
    
    var registerName = ""
    var registerEmail = ""
    var registerPassword = ""
    var registerConfirmPassword = ""
    
    private var authService: AuthService?
    
    func configure(context: ModelContext) async {
        guard authService == nil else { return }
        let service = AuthService(context: context)
        self.authService = service
        
        try? await Task.sleep(for: .milliseconds(6000))
        
        self.currentUser = service.getCurrentSession()
        self.isInitializing = false
    }
    
    var isLoginValid: Bool {
        loginEmail.contains("@") && loginPassword.count >= 6
    }
    
    var isRegisterValid: Bool {
        !registerName.trimmingCharacters(in: .whitespaces).isEmpty &&
        registerEmail.contains("@") &&
        registerPassword.count >= 6 &&
        registerPassword == registerConfirmPassword
    }
    
    func login() async {
        guard isLoginValid, let authService else { return }
        isLoading = true
        errorMessage = nil
        
        try? await Task.sleep(for: .milliseconds(500))
        
        do {
            currentUser = try authService.login(email: loginEmail, password: loginPassword)
            clearForms()
        } catch {
            errorMessage = error.localizedDescription
        }
        
        isLoading = false
    }
    
    func register() async {
        guard isRegisterValid, let authService else { return }
        isLoading = true
        errorMessage = nil
        
        try? await Task.sleep(for: .milliseconds(500))
        
        do {
            currentUser = try authService.register(
                name: registerName,
                email: registerEmail,
                password: registerPassword
            )
            clearForms()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func loginWithGoogle() async {
        guard let authService else { return }
        isLoading = true
        errorMessage = nil
        
        try? await Task.sleep(for: .milliseconds(500))
        
        do {
            currentUser = try authService.socialLogin(
                name: "Usuário Google",
                email: "usuario.gmail.com",
                provider: .google
            )
            clearForms()
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }
    
    func handleAppleSignIn(result: Result<ASAuthorization, Error>) {
        guard let authService else { return }
        
        switch result {
        case .success(let auth):
            if let credential = auth.credential as? ASAuthorizationAppleIDCredential {
                let givenName = credential.fullName?.givenName ?? ""
                let familyName = credential.fullName?.familyName ?? ""
                let fullName = "\(givenName) \(familyName)".trimmingCharacters(in: .whitespaces)
                let finalName = fullName.isEmpty ? "Usuário Apple" : fullName
                let email = credential.email ?? "\(credential.user.prefix(8))@://appleid.com"
                
                do {
                    currentUser = try authService.socialLogin(
                        name: finalName,
                        email: email,
                        provider: .apple
                    )
                    clearForms()
                } catch {
                    errorMessage = error.localizedDescription
                }
            }
        case .failure(let error):
            errorMessage = "Falha na autenticação Apple: \(error.localizedDescription)"
        }
    }
    
    func logout() {
        withAnimation {
            authService?.clearSession()
            currentUser = nil
            clearForms()
        }
    }
    
    func clearForms() {
        loginEmail = ""
        loginPassword = ""
        registerName = ""
        registerEmail = ""
        registerPassword = ""
        registerConfirmPassword = ""
        errorMessage = nil
    }
}
