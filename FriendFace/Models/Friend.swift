//
//  Friend.swift
//  FriendFace
//
//  Created by murad on 06.08.2026.
//

import Foundation
import SwiftData

@Model
final class Friend {
    var id: UUID
    var name: String
    
    init(id: UUID, name: String) {
        self.id = id
        self.name = name
    }
}
