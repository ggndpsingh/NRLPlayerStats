//
//  LeaguePlayer.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 12/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation

struct LeaguePlayer: Codable {
    let id: Int
    let surname: String
    let position: String
    let name: String
    let shortName: String
    let dateOfBirth: Date
    let height: Double
    let otherNames: String
    let weight: Double
    let lastMatchId: String?
    let lastMatchStats: LastMatchStats
    
    private enum CodingKeys: String, CodingKey {
        case id
        case surname
        case position
        case name = "full_name"
        case shortName = "short_name"
        case dateOfBirth = "date_of_birth"
        case height = "height_cm"
        case otherNames = "other_names"
        case weight = "weight_kg"
        case lastMatchId = "last_match_id"
        case lastMatchStats = "last_match_stats"
    }
}

extension LeaguePlayer {
    struct LastMatchStats: Codable {
        let errors: Int?
        let goals: Int?
        let intercepted: Int?
        let intercepts: Int?
        let kicks: Int?
        let points: Int?
        let possessions: Int?
        let runs: Int?
        let tackles: Int?
        let tries: Int?
        let minutesPlayed: Int?
        let attackingKicks: Int?
        let bombsCaught: Int?
        let bombsDropped: Int?
        let chargedDown: Int?
        let changesDown: Int?
        let dropOuts: Int?
        let dummyHalfRuns: Int?
        let effectiveOffloads: Int?
        let fantasyPoints: Int?
        let fieldGoalAttempts: Int?
        let fieldGoalMisses: Int?
        let fieldGoals: Int?
        let forcedDropOuts: Int?
        let generalPlayPass: Int?
        let goalMisses: Int?
        let ineffectiveTackles: Int?
        let inGoalEscapes: Int?
        let interchangesOff: Int?
        let interchangesOn: Int?
        let kickErrors: Int?
        let kickMetres: Int?
        let kickReturnMeters: Int?
        let kickReturns: Int?
        let kicks4020: Int?
        let kicksDead: Int?
        let lastTouchTryAssists: Int?
        let lineBreakAssists: Int?
        let lineBreakCauses: Int?
        let lineBreaks: Int?
        let lineEngagements: Int?
        let longKicks: Int?
        let missedTackles: Int?
        let offLoads: Int?
        let onePassRuns: Int?
        let penalitiesConceded: Int?
        let playTheBalls: Int?
        let runMeters: Int?
        let runs7MetersOrLess: Int?
        let runs8MetersOrMore: Int?
        let sendOffs: Int?
        let sinBins: Int?
        let stealsOneOnOne: Int?
        let stolenOneOnOne: Int?
        let tackleBusts: Int?
        let tackledOpp20: Int?
        let tackledOppHalf: Int?
        let tacklesOneOnOne: Int?
        let tryAssists: Int?
        let tryCauses: Int?
        let tryContributionPercentage: Double?
        let tryContributions: Int?
        let tryInvolvements: Int?
        let twentyMetreRestarts: Int?
        let weightedKicks: Int?
    }
}

extension LeaguePlayer.LastMatchStats {
    private enum CodingKeys: String, CodingKey {
        case errors = "errors"
        case goals = "goals"
        case intercepted = "intercepted"
        case intercepts = "intercepts"
        case kicks = "kicks"
        case points = "points"
        case possessions = "possessions"
        case runs = "runs"
        case tackles = "tackles"
        case tries = "tries"
        case minutesPlayed = "mins_played"
        case attackingKicks = "attacking_kicks"
        case bombsCaught = "bombs_caught"
        case bombsDropped = "bombs_dropped"
        case chargedDown = "charged_down"
        case changesDown = "charges_down"
        case dropOuts = "drop_outs"
        case dummyHalfRuns = "dummy_half_runs"
        case effectiveOffloads = "effective_offloads"
        case fantasyPoints = "fantasy_points"
        case fieldGoalAttempts = "field_goal_attempts"
        case fieldGoalMisses = "field_goal_misses"
        case fieldGoals = "field_goals"
        case forcedDropOuts = "forced_drop_outs"
        case generalPlayPass = "general_play_pass"
        case goalMisses = "goal_misses"
        case ineffectiveTackles = "ineffective_tackles"
        case inGoalEscapes = "in_goal_escapes"
        case interchangesOff = "interchanges_off"
        case interchangesOn = "interchanges_on"
        case kickErrors = "kick_errors"
        case kickMetres = "kick_metres"
        case kickReturnMeters = "kick_return_metres"
        case kickReturns = "kick_returns"
        case kicks4020 = "kicks_4020"
        case kicksDead = "kicks_dead"
        case lastTouchTryAssists = "last_touch_try_assists"
        case lineBreakAssists = "line_break_assists"
        case lineBreakCauses = "line_break_causes"
        case lineBreaks = "line_breaks"
        case lineEngagements = "line_engagements"
        case longKicks = "long_kicks"
        case missedTackles = "missed_tackles"
        case offLoads = "off_loads"
        case onePassRuns = "one_pass_runs"
        case penalitiesConceded = "penalties_conceded"
        case playTheBalls = "play_the_balls"
        case runMeters = "run_metres"
        case runs7MetersOrLess = "runs_7less_meters"
        case runs8MetersOrMore = "runs_8plus_meters"
        case sendOffs = "send_offs"
        case sinBins = "sin_bins"
        case stealsOneOnOne = "steals_one_on_one"
        case stolenOneOnOne = "stolen_one_on_one"
        case tackleBusts = "tackle_busts"
        case tackledOpp20 = "tackled_opp20"
        case tackledOppHalf = "tackle_opp_half"
        case tacklesOneOnOne = "tackles_one_on_one"
        case tryAssists = "try_assists"
        case tryCauses = "try_causes"
        case tryContributionPercentage = "try_contribution_percentage"
        case tryContributions = "try_contributions"
        case tryInvolvements = "try_involvements"
        case twentyMetreRestarts = "twenty_metre_restarts"
        case weightedKicks = "weighted_kicks"
    }
}
