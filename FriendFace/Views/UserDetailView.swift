//
//  UserDetailView.swift
//  FriendFace
//
//  Created by murad on 28.07.2026.
//

import SwiftUI

struct UserDetailView: View {
    let user: User
    let allUsers: [User]
    
    var body: some View {
        List {
            Section("Overview") {
                HStack {
                    Text("Status")
                    Spacer()
                    Text(user.isActive ? "Active" : "Inactive")
                        .foregroundStyle(user.isActive ? .green : .secondary)
                }
                
                HStack {
                    Text("Age")
                    Spacer()
                    Text("\(user.age) years old")
                }
                
                HStack {
                    Text("Registered")
                    Spacer()
                    Text(user.registered.formatted(date: .abbreviated, time: .omitted))
                }
            }
            
            Section("Contact Information") {
                Text("Email: \(user.email)")
                Text("Address: \(user.address)")
                Text("Company: \(user.company)")
            }
            
            Section("About") {
                Text(user.about)
            }
            
            Section("Tags") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(user.uniqueTags, id: \.self) { tag in
                            Text("#\(tag)")
                                .font(.caption)
                                .padding(.horizontal, 10)
                                .padding(.vertical, 5)
                                .background(.blue.opacity(0.1))
                                .clipShape(Capsule())
                        }
                    }
                }
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    if let matchedUser = allUsers.first(where: { $0.id == friend.id }) {
                        NavigationLink(value: matchedUser) {
                            Text(friend.name)
                        }
                    } else {
                        Text(friend.name)
                            .foregroundStyle(.secondary)
                    }
                }
            }
        }
        .navigationTitle(user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserDetailView(user: User.preview, allUsers: [User.preview])
}
