//
//  UserListViewModel.swift
//  FriendFace
//
//  Created by murad on 25.07.2026.
//

import Foundation

@Observable
@MainActor
final class UserListViewModel {
    private(set) var users: [User] = []
    private(set) var isLoading = false
    var errorMessage: String?
    
    private let networkService: NetworkService
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchUsers(force: Bool = false) async {
        if !force {
            guard users.isEmpty else { return }
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            users = try await networkService.fetchUsers()
        } catch {
            errorMessage = "Failed to load users: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
}
