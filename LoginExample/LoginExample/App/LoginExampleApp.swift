//
//  LoginExample.swift
//  LoginExample
//
//  Created by Nazaret, Claiton Milton Augusto on 25/11/26.
//

import SwiftUI
import SwiftData

@main struct LoginExampleApp: App {
    
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: UserEntity.self)
    }
}
