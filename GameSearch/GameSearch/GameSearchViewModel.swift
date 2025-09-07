//
//  GameSearchViewModel.swift
//  
//
//  Created by Joffrey TERRINE on 07/09/2025.
//

// GameSearchViewModel.swift
import Foundation

@MainActor
final class GameSearchViewModel: ObservableObject {
    @Published var query = ""
    @Published var results: [Game] = []
    @Published var isLoading = false
    @Published var hasMore = false
    private var page = 1
    private var currentTask: Task<Void, Never>?

    func onQueryChange() {
        currentTask?.cancel()
        currentTask = Task { [weak self] in
            try? await Task.sleep(nanoseconds: 350_000_000) // debounce ~350ms
            await self?.search(reset: true)
        }
    }

    func search(reset: Bool) async {
        guard !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            results = []; hasMore = false; return
        }
        if reset { page = 1; results = [] }
        isLoading = true
        do {
            let pageData = try await GameAPI.shared.searchGames(query: query, page: page)
            results += pageData.results
            hasMore = pageData.next != nil
            if hasMore { page += 1 }
        } catch {
            // TODO: handle errors (network, rate limit)
        }
        isLoading = false
    }
}
