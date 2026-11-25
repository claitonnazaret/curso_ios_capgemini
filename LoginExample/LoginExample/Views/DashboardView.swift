//
//  DashboardView.swift
//  LoginExample
//
//  Created by Nazaret, Claiton Milton Augusto on 25/11/26.
//

import SwiftUI
import SwiftData

struct DashboardView: View {
    
    var viewModel: AuthViewModel
    
    init(viewModel: AuthViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if let user = viewModel.currentUser {
                        HStack(spacing: 16) {
                            Circle()
                                .fill(.blue.opacity(0.15))
                                    .frame(width: 56, height: 56)
                                .overlay {
                                    Text(user.name.prefix(1).uppercased())
                                        .font(.title2.bold())
                                        .foregroundStyle(.blue)
                                }
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Olá, \(user.name)!")
                                    .font(.headline)
                                Text(user.email)
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                                Text("Logado via \(user.provider.rawValue)")
                                    .font(.caption2.weight(.medium))
                                    .padding(.horizontal, 8)
                                    .padding(.vertical, 2)
                                    .background(.blue.opacity(0.1))
                                    .foregroundStyle(.blue)
                                    .clipShape(Capsule())
                            }
                            Spacer()
                        }
                        .padding()
                        .background(Color(.secondarySystemBackground))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                        DashboardCard(title: "Projetos", value: "12", icon: "folder.fill", color: .blue)
                        DashboardCard(title: "Tarefas", value: "28", icon: "checkmark.circle.fill", color: .green)
                        DashboardCard(title: "Mensagens", value: "5", icon: "envelope.fill", color: .orange)
                        DashboardCard(title: "Alertas", value: "2", icon: "bell.fill", color: .purple)
                    }
                }
                .padding()
            }
            .navigationTitle("Dashboard")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        viewModel.logout()
                    } label: {
                        Label("Sair", systemImage: "rectangle.portrait.and.arrow.right")
                    }
                    
                }
            }
        }
    }
}

struct DashboardCard: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(color)
            Text(value)
                .font(.title.bold())
            Text(title)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(Color(.secondarySystemBackground))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
