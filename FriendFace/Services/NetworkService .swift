//
//  NetworkService .swift
//  FriendFace
//
//  Created by murad on 24.07.2026.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidResponse
    case decodingError
}

struct NetworkService {
    private let baseURL = "https://www.hackingwithswift.com/samples"
    
    func fetchUsers() async throws -> [User] {        
        guard let url = URL(string: "\(baseURL)/friendface.json") else {
            throw NetworkError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkError.invalidResponse
        }
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            return try decoder.decode([User].self, from: data)
        } catch {
            throw NetworkError.decodingError
        }
    }
}
