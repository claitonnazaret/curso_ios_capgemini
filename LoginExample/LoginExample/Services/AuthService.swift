//
//  AuthService.swift
//  LoginExample
//
//  Created by Nazaret, Claiton Milton Augusto on 25/11/26.
//

import Foundation
import SwiftData
import CryptoKit

enum AuthError: LocalizedError {
    case invalidCredentials
    case emailAlreadyInUse
    case databaseError
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "E-mail / senha incorretos."
        case .emailAlreadyInUse:
            return "Este e-mail já está cadastrado."
        case .databaseError:
            return "Erro ao acessar o banco de dados local."
        }
    }
}

@MainActor final class AuthService {
    private let context: ModelContext
    private let sessionKey = "logged_in_user_id"
    
    init(context: ModelContext) {
        self.context = context
    }
    
    private func hashPassword(_ password: String) -> String {
        let digest = SHA256.hash(data: Data(password.utf8))
        return digest.compactMap { String(format: "%02x", $0) }.joined()
    }
    
    func login(email: String, password: String) throws -> UserEntity {
        let normalizedEmail = email.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        let inputHash = hashPassword(password)
        
        let descriptor = FetchDescriptor<UserEntity>(
            predicate: #Predicate { $0.email == normalizedEmail }
        )
        
        guard let user = try context.fetch(descriptor).first,
              user.passwordHash == inputHash else {
            throw AuthError.invalidCredentials
        }
        
        saveSession(userId: user.id)
        return user
    }
    
    func register(name: String, email: String, password: String) throws -> UserEntity {
        let normalizedEmail = email.lowercased().trimmingCharacters(in: .whitespaces)
        
        let descriptor = FetchDescriptor<UserEntity>(
            predicate: #Predicate { $0.email == normalizedEmail }
        )
        
        if try !context.fetch(descriptor).isEmpty {
            throw AuthError.emailAlreadyInUse
        }
        
        let newUser = UserEntity(
            name: name.trimmingCharacters(in: .whitespaces),
            email: normalizedEmail,
            passwordHash: hashPassword(password),
            provider: .email
        )
        
        context.insert(newUser)
        try context.save()
        saveSession(userId: newUser.id)
        return newUser
    }
    
    func socialLogin(name: String, email: String, provider: AuthProvider) throws -> UserEntity {
        let normalizedEmail = email.lowercased().trimmingCharacters(in: .whitespaces)
        
        let descriptor = FetchDescriptor<UserEntity>(
            predicate: #Predicate { $0.email == normalizedEmail }
        )
        
        if let existing = try context.fetch(descriptor).first {
            saveSession(userId: existing.id)
            return existing
        }
        
        let newUser = UserEntity(name: name, email: normalizedEmail, provider: provider)
        context.insert(newUser)
        saveSession(userId: newUser.id)
        return newUser
    }
    
    func getCurrentSession() -> UserEntity? {
        guard let savedIdString = UserDefaults.standard.string(forKey: sessionKey),
              let savedUUID = UUID(uuidString: savedIdString) else {
            return nil
        }
        
        let descriptor = FetchDescriptor<UserEntity>(
            predicate: #Predicate { $0.id == savedUUID }
        )
        return try? context.fetch(descriptor).first
    }
    
    func clearSession() {
        UserDefaults.standard.removeObject(forKey: sessionKey)
    }
    
    private func saveSession(userId: UUID) {
        UserDefaults.standard.set(userId.uuidString, forKey: sessionKey)
    }
}
