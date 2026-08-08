//
//  FriendFaceApp.swift
//  FriendFace
//
//  Created by murad on 24.07.2026.
//

import SwiftUI
import SwiftData

@main
struct FriendFaceApp: App {
    var body: some Scene {
        WindowGroup {
            UserListView()
        }
        .modelContainer(for: User.self)
    }
}
