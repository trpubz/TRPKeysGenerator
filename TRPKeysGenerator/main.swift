//
//  main.swift v0.5
//  TRPKeysGenerator
//
//  Created by Taylor Pubins on 3/25/22.
//  updated by pubins.taylor on 19MAY22

import Foundation

let io = IO()

//load ESPN json players
var tempPlayers: [TPTempPlayer] = io.loadESPNPlayers()
// -MARK: FG
    //load FG Hitters
var fangraphsHitters: [TPFangraphsPlayer] = io.createFGHitters(from: FileManager.urlSteamerrBat)
//load FG Pitchers
var fangraphsPitchers: [TPFangraphsPlayer] = io.createFGPitchers(from: FileManager.urlSteamerrPit)
//combine pos groups into players mega group
var fangraphsPlayers: [TPFangraphsPlayer] = fangraphsHitters + fangraphsPitchers
//find matches--add fangraphs playerid to TempPlayer--pop match from appropriate array
for p in tempPlayers {
    guard let matchID: String = p.findFGMatch(players: fangraphsPlayers).fgid else {
        // if the player exists on ESPN but not on FG projections, the player needs to be shed.
        tempPlayers.removeAll(where: {$0.idESPN == p.idESPN})
        print("removed \(p._name) from ESPN Universe for non-existence in Fangraphs Universe")
        continue
    }
    // if there is a match, make the matchable list shorter by popping match
    fangraphsPlayers.removeAll(where: {$0.playerid == matchID})
    //print(p.name + " " + p.idFangraphs!)
}
// -MARK: Savant
//// load Savant Hitters
//var savantHitters: [SavantPlayer] = io.createSavantHitters(from: FileManager.urlSavantBat)
////load Savant Pitchers
//var savantPitchers: [SavantPlayer] = io.createSavantPitchers(from: FileManager.urlSavantPit)
//combine pos groups into players mega group
var savantPlayers: [TPSavantPlayer] = io.createSavantPlayers(from: FileManager.urlSavant)
//find matches--add fangraphs playerid to TempPlayer--pop match from appropriate array
for p in tempPlayers {
    guard let matchID: String = p.findSavantMatch(players: savantPlayers).idSavant else {
        
        // if the player exists on ESPN but not on FG projections, the player needs to be shed.
        tempPlayers.removeAll(where: {$0.idESPN == p.idESPN})
        print("removed \(p._name) from ESPN Universe for non-existence Savant Universe")
        continue
    }
    // if there is a match, make the matchable list shorter by popping match
    savantPlayers.removeAll(where: {$0.playerid == matchID})
    //print(p.name + " " + p.idFangraphs!)
}

io.writeKeys(keys: tempPlayers)
print("TRPKeysGenerator done executing")
