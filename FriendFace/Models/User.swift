//
//  User.swift
//  FriendFace
//
//  Created by murad on 06.08.2026.
//

import Foundation
import SwiftData

@Model
final class User {
    @Attribute(.unique) var id: UUID
    var isActive: Bool
    var name: String
    var age: Int
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    
    @Relationship(deleteRule: .cascade) var friends: [Friend]
    
    init(
        id: UUID,
        isActive: Bool,
        name: String,
        age: Int,
        company: String,
        email: String,
        address: String,
        about: String,
        registered: Date,
        tags: [String],
        friends: [Friend]
    ) {
        self.id = id
        self.isActive = isActive
        self.name = name
        self.age = age
        self.company = company
        self.email = email
        self.address = address
        self.about = about
        self.registered = registered
        self.tags = tags
        self.friends = friends
    }
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
}
