//
//  CharacterListView.swift
//  IOSFinalProject_F
//
//  Created by Brody Nelson on 5/6/25.
//

import SwiftUI

// The main view displaying the list of characters
struct CharacterListView: View {
    @StateObject private var viewModel = CharacterListViewModel()

    var body: some View {
        NavigationStack {
            // allows for page to be scrollable
            List {
                ForEach(viewModel.characters) { character in
                    // allows for easy navigation between pages
                    NavigationLink(destination: CharacterDetailView(character: character)) {
                        CharacterRowView(character: character)
                            .task {
                                await viewModel.loadMoreIfNeeded(currentItem: character)
                            }
                    }
                }

                // display loading message and error handeling
                if viewModel.isLoading {
                    ProgressView("Loading more characters...")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                } else if let errorMessage = viewModel.errorMessage, !viewModel.characters.isEmpty {
                    Text("Error loading more: \(errorMessage)")
                        .foregroundColor(.red)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                }
            }
            .navigationTitle("Rick & Morty")
            .task {
                if viewModel.characters.isEmpty {
                    await viewModel.fetchCharacters()
                }
            }
            .refreshable {
                await viewModel.refreshCharacters()
            }
            .overlay {
                if viewModel.isLoading && viewModel.characters.isEmpty {
                    ProgressView("Loading Characters...")
                } else if let errorMessage = viewModel.errorMessage, viewModel.characters.isEmpty {
                    VStack {
                        Text("Failed to load characters.")
                            .font(.headline)
                        Text(errorMessage)
                            .font(.callout)
                            .foregroundColor(.gray)
                        Button("Retry") {
                            Task {
                                await viewModel.refreshCharacters()
                            }
                        }
                        .padding(.top)
                    }
                    .padding()
                }
            }
        }
    }
}

// Preview Provider for CharacterListView
struct CharacterListView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterListView()
    }
}
