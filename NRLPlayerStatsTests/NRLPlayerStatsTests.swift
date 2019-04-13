//
//  NRLPlayerStatsTests.swift
//  NRLPlayerStatsTests
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import XCTest
import Alamofire
import Shawshank
@testable import NRLPlayerStats

class NRLPlayerStatsTests: XCTestCase {
    
    let api = TestAPI()
    
    override func tearDown() {
        super.tearDown()
        Shawshank.unbind()
    }
    
    func testCanLoadAndSerialiseMatchStats() {
        let endpoint = TestEndpoint.match
        let expectedPath = api.urlComponents(for: endpoint).path
        let json = Bundle(for: NRLPlayerStatsTests.self).json(named: "validMatchStats")
        
        Shawshank.take(matching: .path(expectedPath)).fixture(json)
        
        let expect = expectation(description: "response successful")
        api.request(endpoint) { (result: Swift.Result<[LeagueStat], APIError>) in
            switch result {
            case .success(let stats):
                XCTAssertEqual(stats.count, 2, "There should be 2 stats.")
                XCTAssertEqual(stats.first?.type, .tackles, "The first stat type should be Tackles.")
                XCTAssertEqual(stats.first?.teamA.name, "Penrith")
                XCTAssertEqual(stats.first?.teamB.name, "Canterbury")
                XCTAssertEqual(stats.first?.teamA.topPlayers.first?.name, "Peter Wallace")
                XCTAssertEqual(stats.first?.teamB.topPlayers.first?.name, "Aiden Tolman")
                
                expect.fulfill()
            case .failure:
                XCTFail();
                return
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
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
    
    func testBadJSON() {
        let endpoint = TestEndpoint.match
        let expectedPath = api.urlComponents(for: endpoint).path
        let json = Bundle(for: NRLPlayerStatsTests.self).json(named: "invalidMatchStats")
        
        Shawshank.take(matching: .path(expectedPath)).fixture(json)
        
        let expect = expectation(description: "response successful")
        api.request(endpoint) { (result: Swift.Result<[LeagueStat], APIError>) in
            switch result {
            case .success:
                XCTFail();
                return
                
            case .failure(let error):
                XCTAssertEqual(error, APIError.responseSerializationFailure)
                expect.fulfill()
            }
        }
        
        waitForExpectations(timeout: 3, handler: nil)
    }
    
    func testCanCorrectlyDecodeStatsFromJSONData() {
        let json = Bundle(for: NRLPlayerStatsTests.self).json(named: "validMatchStats")
        let stats = try? JSONDecoder().decode([LeagueStat].self, from: json.data)
        XCTAssertNotNil(stats)
        XCTAssertEqual(stats?.count, 2)
        XCTAssertEqual(stats?.first?.type, .tackles)
        XCTAssertEqual(stats?.first?.teamA.name, "Penrith")
        XCTAssertEqual(stats?.first?.teamB.name, "Canterbury")
        XCTAssertEqual(stats?.first?.teamA.topPlayers.first?.name, "Peter Wallace")
        XCTAssertEqual(stats?.first?.teamB.topPlayers.first?.name, "Aiden Tolman")
    }
}
