# Migration Guide

## 2025-05-06 Refactoring Update

### Overview
This update introduces a cleaner architecture, improved testability, and consistent coding standards.

### Changes

#### 1. Architecture Refactoring (MVVM)
- **Separation of Concerns**: The monolithic `APIService` has been split/refactored.
    - `CharacterServiceProtocol` introduced for abstraction.
    - `CharacterService` (Actor) handles raw data fetching (`Services/CharacterService.swift`).
    - `CharacterListViewModel` (formerly `APIService` class) manages UI state and business logic (`ViewModels/CharacterListViewModel.swift`).
- **Dependency Injection**: `CharacterListViewModel` now accepts a `CharacterServiceProtocol`, allowing for easy mocking in tests.

#### 2. Views
- `CharacterListView` now uses `CharacterListViewModel` instead of `APIService`.

#### 3. Testing
- Added `CharacterServiceTests.swift` to test ViewModel logic using a mock service.
- Added `CharacterDecodingTests.swift` to verify API response parsing.

#### 4. Tooling & Quality
- Added `.editorconfig` for consistent editor settings.
- Added `.swiftlint.yml` for linting rules.
- Added `.github/workflows/ci.yml` for Continuous Integration (build & test).
- Updated `.gitignore` with standard Swift/Xcode exclusions.

### How to adapt
- **Developers**: Ensure you use `CharacterListViewModel` for character data. Use `CharacterServiceProtocol` if you need to fetch data elsewhere.
- **Testing**: When writing new tests, mock `CharacterServiceProtocol` to isolate tests from network calls.
