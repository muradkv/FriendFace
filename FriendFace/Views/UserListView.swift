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
                if viewModel.isLoading && viewModel.users.isEmpty {
                    ProgressView("Loading users...")
                } else if viewModel.users.isEmpty, let errorMessage = viewModel.errorMessage {
                    ContentUnavailableView {
                        Label("Failed to Load Data", systemImage: "wifi.slash")
                    } description: {
                        Text(errorMessage)
                    } actions: {
                        Button("Try Again") {
                            Task {
                                await viewModel.fetchUsers()
                            }
                        }
                        .buttonStyle(.borderedProminent)
                    }
                } else {
                    List(viewModel.users) { user in
                        NavigationLink(value: user) {
                            UserRowView(user: user)
                        }
                    }
                    .listStyle(.plain)
                    .refreshable {
                        await viewModel.fetchUsers(force: true)
                    }
                }
            }
            .navigationTitle("FriendFace")
            .navigationDestination(for: User.self) { user in
                UserDetailView(user: user, allUsers: viewModel.users)
            }
            .task {
                await viewModel.fetchUsers()
            }
        }
    }
}

#Preview {
    UserListView()
}
