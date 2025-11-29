# iOS Final Project - Rick & Morty App

An iOS application built with SwiftUI that displays characters from the [Rick and Morty API](https://rickandmortyapi.com/).

## 🚀 Demo

(Add screenshots or GIFs here)

## 🛠 Stack

- **Swift** (Latest)
- **SwiftUI** (UI Framework)
- **Combine** (Reactive Programming)
- **MVVM** (Architecture)
- **XCTest** (Testing)

## 🏗 Architecture

The project follows the **Model-View-ViewModel (MVVM)** architectural pattern:

- **Models**: `Character`, `Info`, `Origin`, `Location` (Codable structs matching API response).
- **Views**: `CharacterListView`, `CharacterDetailView`, `CharacterRowView`.
- **ViewModels**: `CharacterListViewModel` (manages state, fetching, pagination).
- **Services**: `CharacterService` (handles networking via `URLSession`).

### Folder Structure

```
IOSFinalProject_F/
├── Models/         # Data models
├── Services/       # Networking & Data fetching
├── ViewModels/     # (Included in Services/APIService.swift for now)
├── Views/          # SwiftUI Views
└── IOSFinalProject_FApp.swift
```

## ⚙️ Setup

1.  Clone the repository.
2.  Open `IOSFinalProject_F.xcodeproj` in Xcode.
3.  Ensure you have a valid signing team selected (or let Xcode manage it automatically).
4.  Build and Run (Cmd+R).

## 🧪 Testing

The project includes unit tests for the Service and ViewModel layers.

Run tests with `Cmd+U` in Xcode.

## 📄 License

This project is licensed under the MIT License.
