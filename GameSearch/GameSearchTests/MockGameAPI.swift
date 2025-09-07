//
//  MockGameAPI.swift
//  
//
//  Created by Joffrey TERRINE on 07/09/2025.
//

// MockGameAPI.swift
import Foundation
import GameSearch

final class MockGameAPI: GameAPI {
    override func searchGames(query: String, page: Int, pageSize: Int) async throws -> Page<Game> {
        return Page(results: [
            Game(id: 1, name: "Fake Game", released: "2024-01-01", rating: 4.5,
                 parent_platforms: [], background_image: nil)
        ], next: nil)
    }
    func testViewModelWithMockAPI() async throws {
        let vm = GameSearchViewModel()
        // injection de dépendance : tu modifies ton VM pour accepter un API en param
        vm.api = MockGameAPI()
        vm.query = "any"
        await vm.search(reset: true)
        XCTAssertEqual(vm.results.first?.name, "Fake Game")
    }
}
