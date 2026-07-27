//
//  Friend.swift
//  FriendFace
//
//  Created by murad on 24.07.2026.
//

import Foundation

struct Friend: Codable, Identifiable, Hashable {
    let id: UUID
    let name: String
}
