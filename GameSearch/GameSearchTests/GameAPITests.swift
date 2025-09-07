//
//  GameAPITests.swift
//  
//
//  Created by Joffrey TERRINE on 07/09/2025.
//

import XCTest
@testable import GameSearch


final class GameAPITests : XCTestCase{
    func testSearchGamesReturnsResults() async throws{
        let api = GameAPI.shared
        let result = try await api.searchGames(query: "zelda",page : 1,pageSize: 5)
    XCTAssertFalse(result.results.isEmpty,"La recherche ne doit pas envoyer d'erreur")
    XCTAssertLessThanOrEqual(result.results.count, 5 , "Le nombre de resultats doit être < a 5.")
    }
}
