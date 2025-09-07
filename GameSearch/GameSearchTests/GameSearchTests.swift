//
//  GameSearchTests.swift
//  GameSearchTests
//
//  Created by Joffrey TERRINE on 07/09/2025.
//

// GameSearchViewModelTests.swift
import XCTest
@testable import GameSearch

final class GameSearchViewModelTests: XCTestCase {

    func testSearchUpdatesResults() async throws {
        // Arrange
        let vm = await GameSearchViewModel()
        vm.query = "mario"
        
        // Act
        await vm.search(reset: true)
        
        // Assert
        XCTAssertFalse(vm.results.isEmpty, "Le ViewModel doit contenir des résultats")
    }
}
