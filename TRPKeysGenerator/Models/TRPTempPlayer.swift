//
//  TempPlayer.swift
//  TRPKeysGenerator
//
//  Created by Taylor Pubins on 3/25/22.
//

import Foundation
import AppKit

class TRPTempPlayer: Codable {
    let _name: String
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
    private var _idSavant: String? = nil
    var idSavant: String? {
        get {
            return _idSavant
        }
        set(newValue) {
            self._idSavant = newValue!
        }
    }
    let firstName: String
    let lastName: String
    var suffix: String? = nil
    let tm: String
    let pos: String
}

extension TRPTempPlayer {
    /// Finds a FG match against self and sets the idFangraphs property if present
    /// - parameter players: Takes an array of FangraphsPlayer s
    /// - returns: a tuple of an optional string representing the player's Fangraphs playerid and/or self
    func findFGMatch(players: [TPFangraphsPlayer]) -> (fgid: String?, plyr: TRPTempPlayer?) {
        // Filter matches on last name first; will sometimes find multiple matches
        var matches: [TPFangraphsPlayer] = findTPMatchesLastName(players: players) as! [TPFangraphsPlayer]
        if matches.isEmpty {
            print("\(self._name) exists in the ESPN world but not in the Fangraphs Projections")
            return (nil, self)
        }
        
        // If only 1 match, then found our guy
        if matches.count == 1 {
            self.idFangraphs = matches.first!.playerid
            return (self.idFangraphs, nil)
        } else if matches.count > 1 {
            // Next filter will be on the first 2 letters
            matches = findTPMatchesFirstName(players: matches) as! [TPFangraphsPlayer]
            if matches.count == 1 {
                self.idFangraphs = matches.first!.playerid
                return (self.idFangraphs, nil)
            } else if matches.count > 1 {
                // Next filter by team
                self.idFangraphs = matches.first(where: {$0.tm == self.tm})!.playerid
                return (self.idFangraphs, nil)
            } else if matches.count > 1 {
                print("still multiple matches...re-evaluate filtering logic")
            }
        }
        return (nil, nil)
    }
    
    /// Finds a Savant match against self and sets the idSavant property if present
    /// - parameter players: Takes an array of SavantPlayer s
    /// - returns: a tuple of an optional string representing the player's Savant playerid and/or self
    func findSavantMatch(players: [TPSavantPlayer]) -> (idSavant: String?, plyr: TRPTempPlayer?) {
        // Filter matches on last name first; will sometimes find multiple matches
        var matches: [TPSavantPlayer] = findTPMatchesLastName(players: players) as! [TPSavantPlayer]
        if matches.isEmpty {
            print("\(self._name) exists in the ESPN world but not in the Statcast Data")
            return (nil, self)
        }
        
        // If only 1 match, then found our guy
        if matches.count == 1 {
            self.idSavant = matches.first!.playerid
            return (self.idSavant, nil)
        } else if matches.count > 1 {
            // Next filter is on the first name
            matches = findTPMatchesFirstName(players: matches) as! [TPSavantPlayer]
            if matches.count == 1 {
                self.idSavant = matches.first!.playerid
                return (self.idSavant, nil)
            } else if matches.count > 1 {
                // Next filter by team
                if matches.count > 1 {
                    self.idSavant = matches.first(where: {$0.tm == self.tm})!.playerid
                    return (self.idFangraphs, nil)
                }
            } else {
                print("espn player: \n\(self._name)")
                matches.forEach({print($0.firstName + " " + $0.lastName)})
                print("still multiple matches...re-evaluate filtering logic")
            }
        }
        return (nil, nil)
    }
}

extension TRPTempPlayer {
    
    private func findTPMatchesLastName(players: [TPExtPlayer]) -> [TPExtPlayer] {
        return players.filter({$0.lastName == self.lastName})
    }
    
    private func findTPMatchesFirstName(players: [TPExtPlayer]) -> [TPExtPlayer] {
        return players.filter({$0.firstName.prefix(2) == self.firstName.prefix(2)})
    }
    
}

extension TRPTempPlayer {
    private enum CodingKeys: String, CodingKey {
        case idESPN, _name, firstName, lastName, suffix, tm, pos
        case _idFangraphs = "idFangraphs"
        case _idSavant = "idSavant"
    }
}
