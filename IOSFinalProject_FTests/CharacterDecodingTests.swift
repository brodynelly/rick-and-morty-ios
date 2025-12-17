//
//  CharacterDecodingTests.swift
//  IOSFinalProject_FTests
//
//  Created by Refactoring Agent on 5/6/25.
//

import XCTest
@testable import IOSFinalProject_F

class CharacterDecodingTests: XCTestCase {

    func testCharacterDecoding() throws {
        let json = """
        {
            "id": 1,
            "name": "Rick Sanchez",
            "status": "Alive",
            "species": "Human",
            "type": "",
            "gender": "Male",
            "origin": {
                "name": "Earth",
                "url": "https://rickandmortyapi.com/api/location/1"
            },
            "location": {
                "name": "Earth",
                "url": "https://rickandmortyapi.com/api/location/20"
            },
            "image": "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
            "episode": [
                "https://rickandmortyapi.com/api/episode/1",
                "https://rickandmortyapi.com/api/episode/2"
            ],
            "url": "https://rickandmortyapi.com/api/character/1",
            "created": "2017-11-04T18:48:46.250Z"
        }
        """.data(using: .utf8)!

        let character = try JSONDecoder().decode(Character.self, from: json)

        XCTAssertEqual(character.id, 1)
        XCTAssertEqual(character.name, "Rick Sanchez")
        XCTAssertEqual(character.origin.name, "Earth")
        XCTAssertEqual(character.episode.count, 2)
    }
}
