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
                    List(viewModel.displayedUsers) { user in
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
            .alert("Refresh Failed", isPresented: $viewModel.showRefreshErrorAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(viewModel.errorMessage ?? "Unknown error")
            }
            .searchable(text: $viewModel.searchText, prompt: "Search by name or company")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Menu {
                        Picker("Sort By", selection: $viewModel.selectedSortOption) {
                            ForEach(UserListViewModel.SortOption.allCases) { option in
                                Text(option.rawValue).tag(option)
                            }
                        }
                    } label: {
                        Label("Sort", systemImage: "arrow.up.arrow.down")
                    }
                }
            }
        }
    }
}

#Preview {
    UserListView()
}
