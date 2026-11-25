//
//  RootView.swift
//  LoginExample
//
//  Created by Nazaret, Claiton Milton Augusto on 25/11/26.
//

import SwiftUI
import SwiftData

struct RootView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var authViewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if authViewModel.isInitializing {
                LoadingView()
                    .transition(.opacity)
            } else if authViewModel.currentUser != nil {
                DashboardView(viewModel: authViewModel)
                    .transition(.move(edge: .trailing).combined(with: .opacity))
            } else {
                LoginView(viewModel: authViewModel)
                    .transition(.move(edge: .leading).combined(with: .opacity))
            }
        }
        .animation(.easeInOut(duration: 0.35), value: authViewModel.isInitializing)
        .animation(.easeInOut(duration: 0.35), value: authViewModel.currentUser != nil)
        .task {
            await authViewModel.configure(context: modelContext)
        }
    }
}

struct LoadingView: View {
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "lock.shield.fill")
                .font(.system(size: 64))
                .foregroundStyle(.blue)
                .symbolEffect(.pulse)
            
            ProgressView()
                .controlSize(.regular)
            
            Text("Carregando sessão...")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground))
    }
}

#Preview {
    RootView()
        .modelContainer(for: UserEntity.self, inMemory: true)
}
