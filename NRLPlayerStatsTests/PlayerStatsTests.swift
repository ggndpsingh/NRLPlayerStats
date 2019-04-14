//
//  PlayerStatsTests.swift
//  NRLPlayerStatsTests
//
//  Created by Gagandeep Singh on 14/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import XCTest
import Shawshank
@testable import NRLPlayerStats

class PlayerStatsTests: XCTestCase {
    
    let api = TestAPI()
    
    func testCanLoadAndSerialisePlayerStats() {
        let endpoint = TestEndpoint.player
        let expectedPath = api.urlComponents(for: endpoint).path
        let json = Bundle(for: NRLPlayerStatsTests.self).json(named: "validPlayerStats")
        
        Shawshank.take(matching: .path(expectedPath)).fixture(json)
        
        let expect = expectation(description: "response successful")
        api.request(endpoint) { (result: Swift.Result<LeaguePlayer, APIError>) in
            switch result {
            case .success(let player):
                XCTAssertEqual(player.name, "Matt Prior")
                XCTAssertEqual(player.position, "Prop")
                XCTAssertEqual(player.lastMatchStats.tackles, 14)
                XCTAssertEqual(player.lastMatchStats.minutesPlayed, 49)
                XCTAssertNil(player.lastMatchStats.fieldGoalAttempts)
                expect.fulfill()
            case .failure:
                XCTFail();
                return
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testPlayerStatsViewState() {
        let json = Bundle(for: NRLPlayerStatsTests.self).json(named: "validPlayerStats")
        let player = try? LeaguePlayer.decode(from: json.data)
        XCTAssertNotNil(player)
        
        let viewState = PlayerStatsViewController.ViewState(player: player)
        XCTAssertEqual(viewState.title, "Matt Prior")
        
        // There are 65 stats in the JSON but 3 are null
        XCTAssertEqual(viewState.numberOfRows(in: 1), 62)
    }
}
