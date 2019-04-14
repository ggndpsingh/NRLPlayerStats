//
//  LocalizedStrings.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 14/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation

enum LocalizedStrings {
    enum common {
        static let error = NSLocalizedString("Error", comment: "")
        static let ok = NSLocalizedString("OK", comment: "")
        static let go = NSLocalizedString("Go", comment: "Title for action button")
    }
    
    enum MatchSelection {
        static let title = NSLocalizedString("NRL 2017 Stats", comment: "Title for NRL Stats for year")
        static let round = NSLocalizedString("Round", comment: "Title for round number picker")
        static let match = NSLocalizedString("Match", comment: "Title for match number picker")
    }
    
    enum MatchStats {
        static let title = NSLocalizedString("Player Stats", comment: "Title for match statistics view")
        static let failureErrorMessage = NSLocalizedString("No stats found for this match", comment: "Displayed when stats failed to load for a match")
    }
    
    enum PlayerStats {
        static let title = NSLocalizedString("Player Stats", comment: "Title for player statistics view")
        static let failureErrorMessage = NSLocalizedString("Failed to load player stats", comment: "Displayed when stats failed to load for a player")
        static let statsHeader = NSLocalizedString("Stats", comment: "Title for header of stats list")
    }
    
    enum MatchStatType {
        static let mostTackles = NSLocalizedString("Most Tackles", comment: "Title for most tackes stat")
        static let mostRuns = NSLocalizedString("Most Rybs", comment: "Title for most runs stat")
        static let mostFantasyPoints = NSLocalizedString("Most Fantasy Points", comment: "Title for most fantasy points stat")
        static let mostDistanceRun = NSLocalizedString("Most Distance Run", comment: "Title for most distance run stat")
    }
    
    enum PlayerStatType {
        static let errors = NSLocalizedString("Errors", comment: "")
        static let goals = NSLocalizedString("Goals", comment: "")
        static let intercepted = NSLocalizedString("Intercepted", comment: "")
        static let intercepts = NSLocalizedString("Intercepts", comment: "")
        static let kicks = NSLocalizedString("Kicks", comment: "")
        static let points = NSLocalizedString("Points", comment: "")
        static let possessions = NSLocalizedString("Possessions", comment: "")
        static let runs = NSLocalizedString("Runs", comment: "")
        static let tackles = NSLocalizedString("Tackles", comment: "")
        static let tries = NSLocalizedString("Tries", comment: "")
        static let minutesPlayed = NSLocalizedString("Minutes Played", comment: "")
        static let attackingKicks = NSLocalizedString("Attacking Kicks", comment: "")
        static let bombsCaught = NSLocalizedString("Bombs Caught", comment: "")
        static let bombsDropped = NSLocalizedString("Bombs Dropped", comment: "")
        static let chargedDown = NSLocalizedString("Charged Down", comment: "")
        static let changesDown = NSLocalizedString("Changes Down", comment: "")
        static let dropOuts = NSLocalizedString("Drop Outs", comment: "")
        static let dummyHalfRuns = NSLocalizedString("Dummy Half Runs", comment: "")
        static let effectiveOffloads = NSLocalizedString("Effective Offloads", comment: "")
        static let fantasyPoints = NSLocalizedString("Fantasy Points", comment: "")
        static let fieldGoalAttempts = NSLocalizedString("Field Goal Attempts", comment: "")
        static let fieldGoalMisses = NSLocalizedString("Field Goal Misses", comment: "")
        static let fieldGoals = NSLocalizedString("Field Goals", comment: "")
        static let forcedDropOuts = NSLocalizedString("Forced Drop Outs", comment: "")
        static let generalPlayPass = NSLocalizedString("General Play Pass", comment: "")
        static let goalMisses = NSLocalizedString("Goal Misses", comment: "")
        static let ineffectiveTackles = NSLocalizedString("Ineffective Tackles", comment: "")
        static let inGoalEscapes = NSLocalizedString("In Goal Escapes", comment: "")
        static let interchangesOff = NSLocalizedString("Interchanges Off", comment: "")
        static let interchangesOn = NSLocalizedString("Interchanges On", comment: "")
        static let kickErrors = NSLocalizedString("Kick Errors", comment: "")
        static let kickMetres = NSLocalizedString("Kick Metres", comment: "")
        static let kickReturnMeters = NSLocalizedString("Kick ReturnMeters", comment: "")
        static let kickReturns = NSLocalizedString("Kick Returns", comment: "")
        static let kicks4020 = NSLocalizedString("Kicks 4020", comment: "")
        static let kicksDead = NSLocalizedString("Kicks Dead", comment: "")
        static let lastTouchTryAssists = NSLocalizedString("Last Touch Try Assists", comment: "")
        static let lineBreakAssists = NSLocalizedString("Line Break Assists", comment: "")
        static let lineBreakCauses = NSLocalizedString("Line Break Causes", comment: "")
        static let lineBreaks = NSLocalizedString("Line Breaks", comment: "")
        static let lineEngagements = NSLocalizedString("Line Engagements", comment: "")
        static let longKicks = NSLocalizedString("Long Kicks", comment: "")
        static let missedTackles = NSLocalizedString("Missed Tackles", comment: "")
        static let offLoads = NSLocalizedString("Off Loads", comment: "")
        static let onePassRuns = NSLocalizedString("One Pass Runs", comment: "")
        static let penalitiesConceded = NSLocalizedString("Penalities Conceded", comment: "")
        static let playTheBalls = NSLocalizedString("Play The Balls", comment: "")
        static let runMeters = NSLocalizedString("Run Meters", comment: "")
        static let runs7MetersOrLess = NSLocalizedString("Runs 7 Meters Or Less", comment: "")
        static let runs8MetersOrMore = NSLocalizedString("Runs 8 Meters Or More", comment: "")
        static let sendOffs = NSLocalizedString("Send Offs", comment: "")
        static let sinBins = NSLocalizedString("Sin Bins", comment: "")
        static let stealsOneOnOne = NSLocalizedString("Steals One On One", comment: "")
        static let stolenOneOnOne = NSLocalizedString("Stolen One On One", comment: "")
        static let tackleBusts = NSLocalizedString("Tackle Busts", comment: "")
        static let tackledOpp20 = NSLocalizedString("Tackled Opposition 20", comment: "")
        static let tackledOppHalf = NSLocalizedString("Tackled Opposition Half", comment: "")
        static let tacklesOneOnOne = NSLocalizedString("Tackles One On One", comment: "")
        static let tryAssists = NSLocalizedString("Try Assists", comment: "")
        static let tryCauses = NSLocalizedString("Try Causes", comment: "")
        static let tryContributionPercentage = NSLocalizedString("Try Contribution Percentage", comment: "")
        static let tryContributions = NSLocalizedString("Try Contributions", comment: "")
        static let tryInvolvements = NSLocalizedString("Try Involvements", comment: "")
        static let twentyMetreRestarts = NSLocalizedString("Twenty Metre Restarts", comment: "")
        static let weightedKicks = NSLocalizedString("Weighted Kicks", comment: "")
        static let noLastMatch = NSLocalizedString("No last match found", comment: "")
    }
}
