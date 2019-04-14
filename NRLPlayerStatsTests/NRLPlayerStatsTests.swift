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
    
    func testInvalidJSONResultsInAnError() {
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
    
    func testMatchStatsViewState() {
        let json = Bundle(for: NRLPlayerStatsTests.self).json(named: "validMatchStats")
        
        let stats = try? [LeagueStat].decode(from: json.data)
        XCTAssertNotNil(stats)
        
        let viewState = MatchStatsViewController.ViewState(stats: stats!)
        XCTAssertEqual(viewState.numberOfSections, 2)
        XCTAssertEqual(viewState.numberOfRows(in: 0), 2)
        XCTAssertEqual(viewState.titleForSection(at: 0), LeagueStat.StatType.tackles.title)
        XCTAssertEqual(viewState.teamsIds(at: IndexPath(row: 1, section: 1)).0, 55011)
    }
}
