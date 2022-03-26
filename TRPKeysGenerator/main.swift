//
//  main.swift
//  TRPKeysGenerator
//
//  Created by Taylor Pubins on 3/25/22.
//

import Foundation

let io = IO()

//load ESPN json players
var tempPlayers: [TempPlayer] = io.loadESPNPlayers()
//load csv Hitters
var fangraphsHitters: [FangraphsPlayer] = io.createFGHitters()
//load csv Pitchers
var fangraphsPitchers: [FangraphsPlayer] = io.createFGPitchers()
//combine pos groups into players mega group
var fangraphsPlayers: [FangraphsPlayer] = fangraphsHitters + fangraphsPitchers
//find matches--add fangraphs playerid to TempPlayer--pop match from appropriate array
for p in tempPlayers {
    guard let match: String = p.findMatch(players: fangraphsPlayers).fgid else {
        // if the player exists on ESPN but not on FG projections, the player needs to be shed.
        tempPlayers.removeAll(where: {$0.idESPN == p.idESPN})
        print("removed \(p.name) for non-existence")
        continue
    }
    fangraphsPlayers.removeAll(where: {$0.playerid == match})
    //print(p.name + " " + p.idFangraphs!)
}

io.writeKeys(keys: tempPlayers)
print("TRPKeysGenerator done executing")
