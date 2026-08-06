//
//  UserDTO.swift
//  FriendFace
//
//  Created by murad on 24.07.2026.
//

import Foundation

struct UserDTO: Decodable {
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
    let friends: [FriendDTO]
}

extension UserDTO {
    func toDomain() -> User {
        var seen = Set<String>()
        let uniqueTags = tags.filter { seen.insert($0).inserted }
        
        let domainFriends = friends.map { Friend(id: $0.id, name: $0.name) }
        
        return User(
            id: id,
            isActive: isActive,
            name: name,
            age: age,
            company: company,
            email: email,
            address: address,
            about: about,
            registered: registered,
            tags: uniqueTags,
            friends: domainFriends
        )
    }
}
