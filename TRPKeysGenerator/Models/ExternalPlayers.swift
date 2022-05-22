//
//  ExternalPlayers.swift
//  TRPKeysGenerator
//
//  Created by Taylor Pubins on 5/22/22.
//

import Foundation

protocol TPExtPlayer {
    var playerid: String { get }
    var firstName: String { get }
    var lastName: String { get }
    var suffix: String? { get }
    var tm: String { get }
}


class TPFangraphsPlayer: Codable, TPExtPlayer {
    var playerid: String
    var name: String
    var firstName: String
    var lastName: String
    var suffix: String? = nil
    var tm: String
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)!.folding(options: .diacriticInsensitive, locale: .current)
        // the playerid string must be trimmed from the carrage return character "\r" for it to not be present in the property
        self.playerid = try values.decodeIfPresent(String.self, forKey: .playerid)!.trimmingCharacters(in: .whitespacesAndNewlines)
        // if the team is blank then coalesce to FA
        let team = try values.decodeIfPresent(String.self, forKey: .tm) ?? "FA"
        self.tm = MLBConversion.convertFG(tm: team)
        let compsName = name.components(separatedBy: " ")
        self.firstName = compsName[0]
        self.lastName = compsName[1]
        if compsName.endIndex > 2 {
            // Hyun Jin Ryu is an
            if compsName[2] == "Jr." || compsName[2] == "Sr." {
                self.suffix = compsName[2]
            } else {
                // Hyun Jin Ryu if not conditioned will produced Ryu as a suffix and Jin as the last name
                // Take the last index as the last name
                self.lastName = compsName[compsName.endIndex - 1]
                // Drop the last name from the name components
                self.firstName = self.name.components(separatedBy: " " + self.lastName)[0]
            }
        }
    }
}

extension TPFangraphsPlayer {
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case tm = "Team"
        case playerid = "playerid"
    }
}

class TPSavantPlayer: Codable, TPExtPlayer {
    var playerid: String
    var firstName: String
    var lastName: String
    var suffix: String? = nil
    var tm: String
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try values.decodeIfPresent(String.self, forKey: .firstName)!.folding(options: .diacriticInsensitive, locale: .current).trimmingCharacters(in: .whitespaces)
        let lastName = try values.decodeIfPresent(String.self, forKey: .lastName)!.folding(options: .diacriticInsensitive, locale: .current).components(separatedBy: " ")
        if lastName.count > 1 {
            self.lastName = lastName[0]
            self.suffix = lastName[1]
        } else {
            self.lastName = lastName[0]
        }
        self.playerid = try values.decodeIfPresent(String.self, forKey: .playerid)!.trimmingCharacters(in: .whitespacesAndNewlines)
        let team = try values.decodeIfPresent(String.self, forKey: .tm) ?? "FA"
        self.tm = MLBConversion.convertSavant(tm: team)
    }
}

extension TPSavantPlayer {
    enum CodingKeys: String, CodingKey {
        case firstName = "FIRSTNAME"
        case lastName = "LASTNAME"
        case playerid = "MLBID"
        case tm = "TEAM"
    }
}
