//
//  ClientAPI.swift
//  
//
//  Created by Joffrey TERRINE on 07/09/2025.
//
// GameAPI.swift

import Foundation

final class GameAPI {
    static let shared = GameAPI()
    private let session = URLSession(configuration: .default)
    private let base = URL(string: "https://api.rawg.io/api")!
    private let apiKey = "786acf5d846e40dfae5ac176229a3c43" // clé côté app (OK pour RAWG)

    struct Page<T: Decodable>: Decodable {
        let results: [T]; let next: String?
    }

    func searchGames(query: String, page: Int = 1, pageSize: Int = 20) async throws -> Page<Game> {
        var comps = URLComponents(url: base.appendingPathComponent("games"), resolvingAgainstBaseURL: false)!
        comps.queryItems = [
            .init(name: "key", value: apiKey),
            .init(name: "search", value: query),
            .init(name: "page", value: "\(page)"),
            .init(name: "page_size", value: "\(pageSize)"),
            .init(name: "search_precise", value: "true")
        ]
        var req = URLRequest(url: comps.url!)
        req.setValue("YourAppName/1.0 (iOS)", forHTTPHeaderField: "User-Agent") // recommandé par RAWG
        let (data, resp) = try await session.data(for: req)
        guard (resp as? HTTPURLResponse)?.statusCode == 200 else { throw URLError(.badServerResponse) }
        return try JSONDecoder().decode(Page<Game>.self, from: data)
    }
}

