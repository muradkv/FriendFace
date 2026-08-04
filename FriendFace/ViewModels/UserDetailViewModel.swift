//
//  UserDetailViewModel.swift
//  FriendFace
//
//  Created by murad on 04.08.2026.
//

import Foundation

@Observable
@MainActor
final class UserDetailViewModel {
    let user: User
    private let allUsers: [User]
    
    init(user: User, allUsers: [User]) {
        self.user = user
        self.allUsers = allUsers
    }
    
    var statusText: String {
        user.isActive ? "Active" : "Inactive"
    }
    
    var formattedAge: String {
        "\(user.age) years old"
    }
    
    var formattedRegistrationDate: String {
        user.registered.formatted(date: .abbreviated, time: .omitted)
    }
    
    var tags: [String] {
        user.uniqueTags
    }
    
    
    func matchedUser(for friend: Friend) -> User? {
        allUsers.first(where: { $0.id == friend.id })
    }
}
