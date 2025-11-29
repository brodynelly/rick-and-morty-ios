//
//  CharacterServiceTests.swift
//  IOSFinalProject_FTests
//
//  Created by Refactoring Agent on 5/6/25.
//

import XCTest
@testable import IOSFinalProject_F

// Mock Service for Testing
actor MockCharacterService: CharacterServiceProtocol {
    var shouldFail = false
    var mockCharacters: [Character] = []

    func fetchCharacters(url: URL) async throws -> (characters: [Character], info: Info) {
        if shouldFail {
            throw URLError(.badServerResponse)
        }
        let info = Info(count: mockCharacters.count, pages: 1, next: nil, prev: nil)
        return (mockCharacters, info)
    }
}

class CharacterServiceTests: XCTestCase {

    var viewModel: CharacterListViewModel!
    var mockService: MockCharacterService!

    override func setUp() {
        super.setUp()
        mockService = MockCharacterService()
        viewModel = CharacterListViewModel(service: mockService)
    }

    override func tearDown() {
        viewModel = nil
        mockService = nil
        super.tearDown()
    }

    func testFetchCharactersSuccess() async {
        // Given
        let character = Character(
            id: 1,
            name: "Rick Sanchez",
            status: "Alive",
            species: "Human",
            type: "",
            gender: "Male",
            origin: Origin(name: "Earth", url: ""),
            location: Location(name: "Earth", url: ""),
            image: "image_url",
            episode: [],
            url: "url",
            created: "date"
        )
        await mockService.setMockCharacters([character])

        // When
        await viewModel.fetchCharacters()

        // Then
        let characters = viewModel.characters
        XCTAssertEqual(characters.count, 1)
        XCTAssertEqual(characters.first?.name, "Rick Sanchez")
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNil(viewModel.errorMessage)
    }

    func testFetchCharactersFailure() async {
        // Given
        await mockService.setShouldFail(true)

        // When
        await viewModel.fetchCharacters()

        // Then
        XCTAssertTrue(viewModel.characters.isEmpty)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertNotNil(viewModel.errorMessage)
    }
}

extension MockCharacterService {
    func setMockCharacters(_ characters: [Character]) {
        self.mockCharacters = characters
    }

    func setShouldFail(_ shouldFail: Bool) {
        self.shouldFail = shouldFail
    }
}
