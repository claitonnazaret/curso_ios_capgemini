//
//  UserEntity.swift
//  LoginExample
//
//  Created by Nazaret, Claiton Milton Augusto on 25/11/26.
//

import Foundation
import SwiftData

enum AuthProvider: String, Codable {
    case email = "E-mail"
    case apple = "Apple"
    case google = "Google"
}

@Model final class UserEntity {
    
    @Attribute(.unique) var id: UUID
    var name: String
    @Attribute(.unique) var email: String
    var passwordHash: String?
    var providerRaw: String
    
    var provider: AuthProvider {
        AuthProvider(rawValue: providerRaw) ?? .email
    }
    
    init(
        id: UUID = UUID(),
        name: String,
        email: String,
        passwordHash: String? = nil,
        provider: AuthProvider,
    ) {
        self.id = id
        self.name = name
        self.email = email
        self.passwordHash = passwordHash
        self.providerRaw = provider.rawValue
    }
}
