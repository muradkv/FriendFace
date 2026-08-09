//
//  UserListViewModel.swift
//  FriendFace
//
//  Created by murad on 25.07.2026.
//

import Foundation
import SwiftData

@Observable
@MainActor
final class UserListViewModel {
    private(set) var users: [User] = []
    private(set) var isLoading = false
    var errorMessage: String?
    
    var searchText = ""
    var selectedSortOption: SortOption = .name
    
    var displayedUsers: [User] {
        let filtered = filter(users, by: searchText)
        return sort(filtered, by: selectedSortOption)
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
    private var modelContext: ModelContext?
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func setModelContext(_ context: ModelContext) {
        self.modelContext = context
    }
    
    func fetchUsers(force: Bool = false) async {
        guard let context = modelContext else { return }
        
        fetchUsersFromDatabase(context: context)
        
        if !force {
            guard users.isEmpty else { return }
        }
        
        isLoading = true
        errorMessage = nil
        
        do {
            users = try await networkService.fetchUsers()
            
            if force {
                try context.delete(model: User.self)
            }
            
            for user in users {
                context.insert(user)
            }
            
            fetchUsersFromDatabase(context: context)
        } catch {
            errorMessage = "Failed to load users: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    private func fetchUsersFromDatabase(context: ModelContext) {
        let descriptor = FetchDescriptor<User>()
        do {
            self.users = try context.fetch(descriptor)
        } catch {
            print("Failed to fetch users from SwiftData: \(error)")
        }
    }
    
    private func filter(_ list: [User], by query: String) -> [User] {
        guard !query.isEmpty else { return list }
        return list.filter { user in
            user.name.localizedCaseInsensitiveContains(query) ||
            user.company.localizedCaseInsensitiveContains(query)
        }
    }
    
    private func sort(_ list: [User], by option: SortOption) -> [User] {
        switch option {
        case .name:
            return list.sorted { $0.name < $1.name }
        case .company:
            return list.sorted { $0.company < $1.company }
        case .age:
            return list.sorted { $0.age < $1.age }
        }
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
