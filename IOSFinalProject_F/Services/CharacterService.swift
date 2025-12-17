//
//  CharacterService.swift
//  IOSFinalProject_F
//
//  Created by Refactoring Agent on 5/6/25.
//

import Foundation

// MARK: - Protocols

protocol CharacterServiceProtocol {
    func fetchCharacters(url: URL) async throws -> (characters: [Character], info: Info)
}

// MARK: - Services

actor CharacterService: CharacterServiceProtocol {
    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func fetchCharacters(url: URL) async throws -> (characters: [Character], info: Info) {
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            throw URLError(.badServerResponse, userInfo: ["StatusCode": statusCode])
        }

        let apiResponse = try JSONDecoder().decode(APIResponse.self, from: data)
        return (apiResponse.results, apiResponse.info)
    }
}
