//
//  UserListView.swift
//  FriendFace
//
//  Created by murad on 24.07.2026.
//

import SwiftUI

struct UserListView: View {
    @State private var viewModel = UserListViewModel()
    
    var body: some View {
        NavigationStack {
            Group {
                if viewModel.isLoading {
                    ProgressView("Loading users...")
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(value: user) {
                            UserRowView(user: user)
                        }
                    }
                    .listStyle(.plain)
                }
            }
            .navigationTitle("FriendFace")
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user, allUsers: viewModel.users)
            }
            .task {
                await viewModel.fetchUsers()
            }
            .alert("Error", isPresented: Binding(
                get: { viewModel.errorMessage != nil },
                set: { _ in viewModel.errorMessage = nil }
            )) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            }
        }
    }
}

#Preview {
    UserListView()
}
