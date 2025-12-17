//
//  CharacterListViewModel.swift
//  IOSFinalProject_F
//
//  Created by Refactoring Agent on 5/6/25.
//

import Foundation
import Combine

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false

    private let service: CharacterServiceProtocol
    private var currentPage = 1
    private var totalPages = 1
    private var nextURL: String? = "https://rickandmortyapi.com/api/character"

    init(service: CharacterServiceProtocol = CharacterService()) {
        self.service = service
    }

    @MainActor
    func fetchCharacters() async {
        guard !isLoading, let urlString = nextURL else {
            if nextURL == nil {
                print("DEBUG: Reached end of character list or no URL.")
            } else if isLoading {
                print("DEBUG: Fetch request ignored, already loading.")
            }
            return
        }

        guard let url = URL(string: urlString) else {
            errorMessage = "Invalid URL: \(urlString)"
            print("DEBUG: Invalid URL - \(urlString)")
            return
        }

        isLoading = true
        errorMessage = nil
        print("DEBUG: Fetching characters from URL: \(url)")

        do {
            let (newCharacters, info) = try await service.fetchCharacters(url: url)

            characters.append(contentsOf: newCharacters)
            nextURL = info.next
            totalPages = info.pages
            currentPage += 1
            print("DEBUG: Successfully fetched page. Total characters: \(characters.count). Next URL: \(nextURL ?? "None")")

        } catch {
            errorMessage = "Failed to fetch or decode data: \(error.localizedDescription)"
            print("DEBUG: Error fetching/decoding data: \(error)")
        }

        isLoading = false
    }

    @MainActor
    func loadMoreIfNeeded(currentItem item: Character?) {
        guard let item = item else {
            Task {
                await fetchCharacters()
            }
            return
        }

        let thresholdIndex = characters.index(characters.endIndex, offsetBy: -5)
        if characters.firstIndex(where: { $0.id == item.id }) == thresholdIndex {
            print("DEBUG: Threshold reached by item \(item.name). Loading more.")
            Task {
                await fetchCharacters()
            }
        }
    }

    @MainActor
    func refreshCharacters() async {
        print("DEBUG: Refreshing characters...")
        characters = []
        nextURL = "https://rickandmortyapi.com/api/character"
        currentPage = 1
        isLoading = false
        errorMessage = nil

        await fetchCharacters()
    }
}
