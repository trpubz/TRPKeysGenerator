//
//  TempPlayer.swift
//  TRPKeysGenerator
//
//  Created by Taylor Pubins on 3/25/22.
//

import Foundation

class TempPlayer: Codable {
    let idESPN: String
    private var _idFangraphs: String? = nil
    var idFangraphs: String? {
        get {
            return _idFangraphs
        }
        set (newValue) {
            self._idFangraphs = newValue!
        }
    }
    let name: String
    let firstName: String
    let lastName: String
    var suffix: String? = nil
    let tm: String
    let pos: String
}

extension TempPlayer {
    /// Finds a match against self and sets the idFangraphs property if present
    /// - Parameter players: Takes an array of FangraphsPlayer s
    /// - Returns: An optional string representing the player's Fangraphs playerid and/or self
    func findMatch(players: [FangraphsPlayer]) -> (fgid: String?, plyr: TempPlayer?) {
        var matches: [FangraphsPlayer] = players.filter({$0.lastName == self.lastName})
        if matches.isEmpty {
            print("\(self.name) exists in the ESPN world but not in the Fangraphs Projections")
            return (nil, self)
        }
        if matches.count == 1 {
            self.idFangraphs = matches.first!.playerid
            return (self.idFangraphs, nil)
        } else if matches.count > 1 {
            matches = matches.filter({$0.firstName.prefix(2) == self.firstName.prefix(2)})
            if matches.count == 1 {
                self.idFangraphs = matches.first!.playerid
                return (self.idFangraphs, nil)
            } else if matches.count > 1 {
                self.idFangraphs = matches.first(where: {$0.tm == self.tm})!.playerid
                return (self.idFangraphs, nil)
            }
        }
        return (nil, nil)
    }
}

extension TempPlayer {
    private enum CodingKeys: String, CodingKey {
        case idESPN, name, firstName, lastName, suffix, tm, pos
        case _idFangraphs = "idFangraphs"
        
    }
}
