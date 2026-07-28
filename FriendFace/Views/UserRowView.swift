//
//  UserRowView.swift
//  FriendFace
//
//  Created by murad on 26.07.2026.
//

import SwiftUI

struct UserRowView: View {
    let user: User
    
    var body: some View {
        HStack(spacing: 12) {
            Circle()
                .fill(user.isActive ? .green : .gray)
                .frame(width: 10, height: 10)
            
            VStack(alignment: .leading, spacing: 4) {
                Text(user.name)
                    .font(.headline)
                
                Text(user.company)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 4)
    }
}

#Preview {
    UserRowView(user: User.preview)
}
