//
//  UserDetailView.swift
//  FriendFace
//
//  Created by murad on 28.07.2026.
//

import SwiftUI

struct UserDetailView: View {
    @State private var viewModel: UserDetailViewModel
    
    init(user: User, allUsers: [User]) {
        _viewModel = State(wrappedValue: UserDetailViewModel(user: user, allUsers: allUsers))
    }
    
    var body: some View {
        List {
            Section("Overview") {
                HStack {
                    Text("Status")
                    Spacer()
                    Text(viewModel.statusText)
                        .foregroundStyle(viewModel.user.isActive ? .green : .secondary)
                }
                
                HStack {
                    Text("Age")
                    Spacer()
                    Text(viewModel.formattedAge)
                }
                
                HStack {
                    Text("Registered")
                    Spacer()
                    Text(viewModel.formattedRegistrationDate)
                }
            }
            
            Section("Contact Information") {
                Text("Email: \(viewModel.user.email)")
                Text("Address: \(viewModel.user.address)")
                Text("Company: \(viewModel.user.company)")
            }
            
            Section("About") {
                Text(viewModel.user.about)
            }
            
            Section("Tags") {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack {
                        ForEach(viewModel.tags, id: \.self) { tag in
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
                ForEach(viewModel.user.friends) { friend in
                    if let matchedUser = viewModel.matchedUser(for: friend) {
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
        .navigationTitle(viewModel.user.name)
        .navigationBarTitleDisplayMode(.inline)
    }
}

#Preview {
    UserDetailView(user: User.preview, allUsers: [User.preview])
}
