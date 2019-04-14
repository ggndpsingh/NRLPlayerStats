//
//  PlayerStatsViewController+ViewState.swift
//  NRLPlayerStats
//
//  Created by Gagandeep Singh on 13/4/19.
//  Copyright © 2019 Gagandeep Singh. All rights reserved.
//

import Foundation
import UIKit

extension PlayerStatsViewController {
    struct ViewState {
        private var rows: [Row] = []
        
        let title: String?
        let playerDetailsViewState: PlayerDetailsCell.ViewState
        
        let numberOfSections: Int = 2
        
        func numberOfRows(in section: Int) -> Int {
            return section == 0 ? 1 : rows.count
        }
        
        func heightForHeader(in section: Int) -> CGFloat {
            return section == 0 ? 0 : 44
        }
        
        func titleForHeader(in section: Int) -> String? {
            return section == 0 ? nil : LocalizedStrings.PlayerStats.statsHeader
        }
        
        func title(at indexPath: IndexPath) -> String? {
            guard indexPath.section != 0 else { return nil }
            return rows.element(at: indexPath.row)?.title
        }
        
        func value(at indexPath: IndexPath) -> String? {
            guard indexPath.section != 0 else { return nil }
            return rows.element(at: indexPath.row)?.stringValue
        }
        
        init(player: LeaguePlayer? = nil) {
            title = player?.name
            playerDetailsViewState = .init(player: player)
            
            guard let _ = player?.lastMatchId else {
                rows.append(.noLastMatch)
                return
            }
            
            if let errors = player?.lastMatchStats.errors {
                rows.append(.errors(errors))
            }
            if let goals = player?.lastMatchStats.goals {
                rows.append(.goals(goals))
            }
            if let intercepted = player?.lastMatchStats.intercepted {
                rows.append(.intercepted(intercepted))
            }
            if let intercepts = player?.lastMatchStats.intercepts {
                rows.append(.intercepts(intercepts))
            }
            if let kicks = player?.lastMatchStats.kicks {
                rows.append(.kicks(kicks))
            }
            if let points = player?.lastMatchStats.points {
                rows.append(.points(points))
            }
            if let possessions = player?.lastMatchStats.possessions {
                rows.append(.possessions(possessions))
            }
            if let runs = player?.lastMatchStats.runs {
                rows.append(.runs(runs))
            }
            if let tackles = player?.lastMatchStats.tackles {
                rows.append(.tackles(tackles))
            }
            if let tries = player?.lastMatchStats.tries {
                rows.append(.tries(tries))
            }
            if let minutesPlayed = player?.lastMatchStats.minutesPlayed {
                rows.append(.minutesPlayed(minutesPlayed))
            }
            if let attackingKicks = player?.lastMatchStats.attackingKicks {
                rows.append(.attackingKicks(attackingKicks))
            }
            if let bombsCaught = player?.lastMatchStats.bombsCaught {
                rows.append(.bombsCaught(bombsCaught))
            }
            if let bombsDropped = player?.lastMatchStats.bombsDropped {
                rows.append(.bombsDropped(bombsDropped))
            }
            if let chargedDown = player?.lastMatchStats.chargedDown {
                rows.append(.chargedDown(chargedDown))
            }
            if let changesDown = player?.lastMatchStats.changesDown {
                rows.append(.changesDown(changesDown))
            }
            if let dropOuts = player?.lastMatchStats.dropOuts {
                rows.append(.dropOuts(dropOuts))
            }
            if let dummyHalfRuns = player?.lastMatchStats.dummyHalfRuns {
                rows.append(.dummyHalfRuns(dummyHalfRuns))
            }
            if let effectiveOffloads = player?.lastMatchStats.effectiveOffloads {
                rows.append(.effectiveOffloads(effectiveOffloads))
            }
            if let fantasyPoints = player?.lastMatchStats.fantasyPoints {
                rows.append(.fantasyPoints(fantasyPoints))
            }
            if let fieldGoalAttempts = player?.lastMatchStats.fieldGoalAttempts {
                rows.append(.fieldGoalAttempts(fieldGoalAttempts))
            }
            if let fieldGoalMisses = player?.lastMatchStats.fieldGoalMisses {
                rows.append(.fieldGoalMisses(fieldGoalMisses))
            }
            if let fieldGoals = player?.lastMatchStats.fieldGoals {
                rows.append(.fieldGoals(fieldGoals))
            }
            if let forcedDropOuts = player?.lastMatchStats.forcedDropOuts {
                rows.append(.forcedDropOuts(forcedDropOuts))
            }
            if let generalPlayPass = player?.lastMatchStats.generalPlayPass {
                rows.append(.generalPlayPass(generalPlayPass))
            }
            if let goalMisses = player?.lastMatchStats.goalMisses {
                rows.append(.goalMisses(goalMisses))
            }
            if let ineffectiveTackles = player?.lastMatchStats.ineffectiveTackles {
                rows.append(.ineffectiveTackles(ineffectiveTackles))
            }
            if let inGoalEscapes = player?.lastMatchStats.inGoalEscapes {
                rows.append(.inGoalEscapes(inGoalEscapes))
            }
            if let interchangesOff = player?.lastMatchStats.interchangesOff {
                rows.append(.interchangesOff(interchangesOff))
            }
            if let interchangesOn = player?.lastMatchStats.interchangesOn {
                rows.append(.interchangesOn(interchangesOn))
            }
            if let kickErrors = player?.lastMatchStats.kickErrors {
                rows.append(.kickErrors(kickErrors))
            }
            if let kickMetres = player?.lastMatchStats.kickMetres {
                rows.append(.kickMetres(kickMetres))
            }
            if let kickReturnMeters = player?.lastMatchStats.kickReturnMeters {
                rows.append(.kickReturnMeters(kickReturnMeters))
            }
            if let kickReturns = player?.lastMatchStats.kickReturns {
                rows.append(.kickReturns(kickReturns))
            }
            if let kicks4020 = player?.lastMatchStats.kicks4020 {
                rows.append(.kicks4020(kicks4020))
            }
            if let kicksDead = player?.lastMatchStats.kicksDead {
                rows.append(.kicksDead(kicksDead))
            }
            if let lastTouchTryAssists = player?.lastMatchStats.lastTouchTryAssists {
                rows.append(.lastTouchTryAssists(lastTouchTryAssists))
            }
            if let lineBreakAssists = player?.lastMatchStats.lineBreakAssists {
                rows.append(.lineBreakAssists(lineBreakAssists))
            }
            if let lineBreakCauses = player?.lastMatchStats.lineBreakCauses {
                rows.append(.lineBreakCauses(lineBreakCauses))
            }
            if let lineBreaks = player?.lastMatchStats.lineBreaks {
                rows.append(.lineBreaks(lineBreaks))
            }
            if let lineEngagements = player?.lastMatchStats.lineEngagements {
                rows.append(.lineEngagements(lineEngagements))
            }
            if let longKicks = player?.lastMatchStats.longKicks {
                rows.append(.longKicks(longKicks))
            }
            if let missedTackles = player?.lastMatchStats.missedTackles {
                rows.append(.missedTackles(missedTackles))
            }
            if let offLoads = player?.lastMatchStats.offLoads {
                rows.append(.offLoads(offLoads))
            }
            if let onePassRuns = player?.lastMatchStats.onePassRuns {
                rows.append(.onePassRuns(onePassRuns))
            }
            if let penalitiesConceded = player?.lastMatchStats.penalitiesConceded {
                rows.append(.penalitiesConceded(penalitiesConceded))
            }
            if let playTheBalls = player?.lastMatchStats.playTheBalls {
                rows.append(.playTheBalls(playTheBalls))
            }
            if let runMeters = player?.lastMatchStats.runMeters {
                rows.append(.runMeters(runMeters))
            }
            if let runs7MetersOrLess = player?.lastMatchStats.runs7MetersOrLess {
                rows.append(.runs7MetersOrLess(runs7MetersOrLess))
            }
            if let runs8MetersOrMore = player?.lastMatchStats.runs8MetersOrMore {
                rows.append(.runs8MetersOrMore(runs8MetersOrMore))
            }
            if let sendOffs = player?.lastMatchStats.sendOffs {
                rows.append(.sendOffs(sendOffs))
            }
            if let sinBins = player?.lastMatchStats.sinBins {
                rows.append(.sinBins(sinBins))
            }
            if let stealsOneOnOne = player?.lastMatchStats.stealsOneOnOne {
                rows.append(.stealsOneOnOne(stealsOneOnOne))
            }
            if let stolenOneOnOne = player?.lastMatchStats.stolenOneOnOne {
                rows.append(.stolenOneOnOne(stolenOneOnOne))
            }
            if let tackleBusts = player?.lastMatchStats.tackleBusts {
                rows.append(.tackleBusts(tackleBusts))
            }
            if let tackledOpp20 = player?.lastMatchStats.tackledOpp20 {
                rows.append(.tackledOpp20(tackledOpp20))
            }
            if let tackledOppHalf = player?.lastMatchStats.tackledOppHalf {
                rows.append(.tackledOppHalf(tackledOppHalf))
            }
            if let tacklesOneOnOne = player?.lastMatchStats.tacklesOneOnOne {
                rows.append(.tacklesOneOnOne(tacklesOneOnOne))
            }
            if let tryAssists = player?.lastMatchStats.tryAssists {
                rows.append(.tryAssists(tryAssists))
            }
            if let tryCauses = player?.lastMatchStats.tryCauses {
                rows.append(.tryCauses(tryCauses))
            }
            if let tryContributionPercentage = player?.lastMatchStats.tryContributionPercentage {
                rows.append(.tryContributionPercentage(tryContributionPercentage))
            }
            if let tryContributions = player?.lastMatchStats.tryContributions {
                rows.append(.tryContributions(tryContributions))
            }
            if let tryInvolvements = player?.lastMatchStats.tryInvolvements {
                rows.append(.tryInvolvements(tryInvolvements))
            }
            if let twentyMetreRestarts = player?.lastMatchStats.twentyMetreRestarts {
                rows.append(.twentyMetreRestarts(twentyMetreRestarts))
            }
            if let weightedKicks = player?.lastMatchStats.weightedKicks {
                rows.append(.weightedKicks(weightedKicks))
            }
        }
    }
}

extension PlayerStatsViewController.ViewState {
    enum Row {
        case errors(Int?)
        case goals(Int?)
        case intercepted(Int?)
        case intercepts(Int?)
        case kicks(Int?)
        case points(Int?)
        case possessions(Int?)
        case runs(Int?)
        case tackles(Int?)
        case tries(Int?)
        case minutesPlayed(Int?)
        case attackingKicks(Int?)
        case bombsCaught(Int?)
        case bombsDropped(Int?)
        case chargedDown(Int?)
        case changesDown(Int?)
        case dropOuts(Int?)
        case dummyHalfRuns(Int?)
        case effectiveOffloads(Int?)
        case fantasyPoints(Int?)
        case fieldGoalAttempts(Int?)
        case fieldGoalMisses(Int?)
        case fieldGoals(Int?)
        case forcedDropOuts(Int?)
        case generalPlayPass(Int?)
        case goalMisses(Int?)
        case ineffectiveTackles(Int?)
        case inGoalEscapes(Int?)
        case interchangesOff(Int?)
        case interchangesOn(Int?)
        case kickErrors(Int?)
        case kickMetres(Int?)
        case kickReturnMeters(Int?)
        case kickReturns(Int?)
        case kicks4020(Int?)
        case kicksDead(Int?)
        case lastTouchTryAssists(Int?)
        case lineBreakAssists(Int?)
        case lineBreakCauses(Int?)
        case lineBreaks(Int?)
        case lineEngagements(Int?)
        case longKicks(Int?)
        case missedTackles(Int?)
        case offLoads(Int?)
        case onePassRuns(Int?)
        case penalitiesConceded(Int?)
        case playTheBalls(Int?)
        case runMeters(Int?)
        case runs7MetersOrLess(Int?)
        case runs8MetersOrMore(Int?)
        case sendOffs(Int?)
        case sinBins(Int?)
        case stealsOneOnOne(Int?)
        case stolenOneOnOne(Int?)
        case tackleBusts(Int?)
        case tackledOpp20(Int?)
        case tackledOppHalf(Int?)
        case tacklesOneOnOne(Int?)
        case tryAssists(Int?)
        case tryCauses(Int?)
        case tryContributionPercentage(Double?)
        case tryContributions(Int?)
        case tryInvolvements(Int?)
        case twentyMetreRestarts(Int?)
        case weightedKicks(Int?)
        
        case noLastMatch
        
        var title: String {
            switch self {
            case .errors:
                return LocalizedStrings.PlayerStatType.errors
            case .goals:
                return LocalizedStrings.PlayerStatType.goals
            case .intercepted:
                return LocalizedStrings.PlayerStatType.intercepted
            case .intercepts:
                return LocalizedStrings.PlayerStatType.intercepts
            case .kicks:
                return LocalizedStrings.PlayerStatType.kicks
            case .points:
                return LocalizedStrings.PlayerStatType.points
            case .possessions:
                return LocalizedStrings.PlayerStatType.possessions
            case .runs:
                return LocalizedStrings.PlayerStatType.runs
            case .tackles:
                return LocalizedStrings.PlayerStatType.tackles
            case .tries:
                return LocalizedStrings.PlayerStatType.tries
            case .minutesPlayed:
                return LocalizedStrings.PlayerStatType.minutesPlayed
            case .attackingKicks:
                return LocalizedStrings.PlayerStatType.attackingKicks
            case .bombsCaught:
                return LocalizedStrings.PlayerStatType.bombsCaught
            case .bombsDropped:
                return LocalizedStrings.PlayerStatType.bombsDropped
            case .chargedDown:
                return LocalizedStrings.PlayerStatType.chargedDown
            case .changesDown:
                return LocalizedStrings.PlayerStatType.changesDown
            case .dropOuts:
                return LocalizedStrings.PlayerStatType.dropOuts
            case .dummyHalfRuns:
                return LocalizedStrings.PlayerStatType.dummyHalfRuns
            case .effectiveOffloads:
                return LocalizedStrings.PlayerStatType.effectiveOffloads
            case .fantasyPoints:
                return LocalizedStrings.PlayerStatType.fantasyPoints
            case .fieldGoalAttempts:
                return LocalizedStrings.PlayerStatType.fieldGoalAttempts
            case .fieldGoalMisses:
                return LocalizedStrings.PlayerStatType.fieldGoalMisses
            case .fieldGoals:
                return LocalizedStrings.PlayerStatType.fieldGoals
            case .forcedDropOuts:
                return LocalizedStrings.PlayerStatType.forcedDropOuts
            case .generalPlayPass:
                return LocalizedStrings.PlayerStatType.generalPlayPass
            case .goalMisses:
                return LocalizedStrings.PlayerStatType.goalMisses
            case .ineffectiveTackles:
                return LocalizedStrings.PlayerStatType.ineffectiveTackles
            case .inGoalEscapes:
                return LocalizedStrings.PlayerStatType.inGoalEscapes
            case .interchangesOff:
                return LocalizedStrings.PlayerStatType.interchangesOff
            case .interchangesOn:
                return LocalizedStrings.PlayerStatType.interchangesOn
            case .kickErrors:
                return LocalizedStrings.PlayerStatType.kickErrors
            case .kickMetres:
                return LocalizedStrings.PlayerStatType.kickMetres
            case .kickReturnMeters:
                return LocalizedStrings.PlayerStatType.kickReturnMeters
            case .kickReturns:
                return LocalizedStrings.PlayerStatType.kickReturns
            case .kicks4020:
                return LocalizedStrings.PlayerStatType.kicks4020
            case .kicksDead:
                return LocalizedStrings.PlayerStatType.kicksDead
            case .lastTouchTryAssists:
                return LocalizedStrings.PlayerStatType.lastTouchTryAssists
            case .lineBreakAssists:
                return LocalizedStrings.PlayerStatType.lineBreakAssists
            case .lineBreakCauses:
                return LocalizedStrings.PlayerStatType.lineBreakCauses
            case .lineBreaks:
                return LocalizedStrings.PlayerStatType.lineBreaks
            case .lineEngagements:
                return LocalizedStrings.PlayerStatType.lineEngagements
            case .longKicks:
                return LocalizedStrings.PlayerStatType.longKicks
            case .missedTackles:
                return LocalizedStrings.PlayerStatType.missedTackles
            case .offLoads:
                return LocalizedStrings.PlayerStatType.offLoads
            case .onePassRuns:
                return LocalizedStrings.PlayerStatType.onePassRuns
            case .penalitiesConceded:
                return LocalizedStrings.PlayerStatType.penalitiesConceded
            case .playTheBalls:
                return LocalizedStrings.PlayerStatType.playTheBalls
            case .runMeters:
                return LocalizedStrings.PlayerStatType.runMeters
            case .runs7MetersOrLess:
                return LocalizedStrings.PlayerStatType.runs7MetersOrLess
            case .runs8MetersOrMore:
                return LocalizedStrings.PlayerStatType.runs8MetersOrMore
            case .sendOffs:
                return LocalizedStrings.PlayerStatType.sendOffs
            case .sinBins:
                return LocalizedStrings.PlayerStatType.sinBins
            case .stealsOneOnOne:
                return LocalizedStrings.PlayerStatType.stealsOneOnOne
            case .stolenOneOnOne:
                return LocalizedStrings.PlayerStatType.stolenOneOnOne
            case .tackleBusts:
                return LocalizedStrings.PlayerStatType.tackleBusts
            case .tackledOpp20:
                return LocalizedStrings.PlayerStatType.tackledOpp20
            case .tackledOppHalf:
                return LocalizedStrings.PlayerStatType.tackledOppHalf
            case .tacklesOneOnOne:
                return LocalizedStrings.PlayerStatType.tacklesOneOnOne
            case .tryAssists:
                return LocalizedStrings.PlayerStatType.tryAssists
            case .tryCauses:
                return LocalizedStrings.PlayerStatType.tryCauses
            case .tryContributionPercentage:
                return LocalizedStrings.PlayerStatType.tryContributionPercentage
            case .tryContributions:
                return LocalizedStrings.PlayerStatType.tryContributions
            case .tryInvolvements:
                return LocalizedStrings.PlayerStatType.tryInvolvements
            case .twentyMetreRestarts:
                return LocalizedStrings.PlayerStatType.twentyMetreRestarts
            case .weightedKicks:
                return LocalizedStrings.PlayerStatType.weightedKicks
                
            case .noLastMatch:
                return LocalizedStrings.PlayerStatType.noLastMatch + " 😞"
            }
        }
        
        var stringValue: String? {
            switch self {
            case .errors(let value), .goals(let value), .intercepted(let value), .intercepts(let value), .kicks(let value),
                 .points(let value), .possessions(let value), .runs(let value), .tackles(let value), .tries(let value), .minutesPlayed(let value),
                 .attackingKicks(let value), .bombsCaught(let value), .bombsDropped(let value), .chargedDown(let value), .changesDown(let value),
                 .dropOuts(let value), .dummyHalfRuns(let value), .effectiveOffloads(let value), .fantasyPoints(let value), .fieldGoalAttempts(let value),
                 .fieldGoalMisses(let value), .fieldGoals(let value), .forcedDropOuts(let value), .generalPlayPass(let value),
                 .goalMisses(let value), .ineffectiveTackles(let value), .inGoalEscapes(let value), .interchangesOff(let value), .interchangesOn(let value),
                 .kickErrors(let value), .kickMetres(let value), .kickReturnMeters(let value), .kickReturns(let value), .kicks4020(let value),
                 .kicksDead(let value), .lastTouchTryAssists(let value), .lineBreakAssists(let value), .lineBreakCauses(let value), .lineBreaks(let value),
                 .lineEngagements(let value), .longKicks(let value), .missedTackles(let value), .offLoads(let value), .onePassRuns(let value),
                 .penalitiesConceded(let value), .playTheBalls(let value), .runMeters(let value), .runs7MetersOrLess(let value), .runs8MetersOrMore(let value),
                 .sendOffs(let value), .sinBins(let value), .stealsOneOnOne(let value), .stolenOneOnOne(let value), .tackleBusts(let value),
                 .tackledOpp20(let value), .tackledOppHalf(let value), .tacklesOneOnOne(let value), .tryAssists(let value), .tryCauses(let value),
                 .tryContributions(let value), .tryInvolvements(let value), .twentyMetreRestarts(let value), .weightedKicks(let value):
                return value.map { "\($0)"}
                
            case .tryContributionPercentage(let value):
                return value.map { "\($0)"}
                
            case .noLastMatch:
                return nil
            }
        }
    }
}
