//
//  User.swift
//  FriendFace
//
//  Created by murad on 24.07.2026.
//

import Foundation

struct User: Codable, Identifiable, Hashable {
    let id: UUID
    let isActive: Bool
    let name: String
    let age: Int
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
}

extension User {
    static let preview = User(
        id: UUID(),
        isActive: true,
        name: "John Doe",
        age: 30,
        company: "Apple",
        email: "john.doe@apple.com",
        address: "1 Infinite Loop, Cupertino, CA",
        about: "iOS Developer and enthusiast.",
        registered: Date(),
        tags: ["swift", "swiftui", "ios"],
        friends: [Friend(id: UUID(), name: "Jane Smith")]
    )
    
    var uniqueTags: [String] {
        var seen = Set<String>()
        return tags.filter { seen.insert($0).inserted }
    }
}
