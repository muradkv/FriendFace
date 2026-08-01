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
    
    var selectedSortOption: SortOption = .name
    
    var sortedUsers: [User] {
        switch selectedSortOption {
        case .name:
            return users.sorted { $0.name < $1.name }
        case .company:
            return users.sorted { $0.company < $1.company }
        case .age:
            return users.sorted { $0.age < $1.age }
        }
    }
    
    var showRefreshErrorAlert: Bool {
        get {
            return errorMessage != nil && !users.isEmpty
            
        }
        set {
            if !newValue {
                errorMessage = nil
            }
        }
    }
    
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

extension UserListViewModel {
    enum SortOption: String, CaseIterable, Identifiable {
        case name = "Name"
        case company = "Company"
        case age = "Age"
        
        var id: Self { self }
    }
}
