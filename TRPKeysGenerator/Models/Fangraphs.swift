//
//  Fangraphs.swift
//  TRPKeysGenerator
//
//  Created by Taylor Pubins on 3/25/22.
//

import Foundation

class FangraphsPlayer: Codable {
    let playerid: String
    let name: String
    let firstName: String
    let lastName: String
    var suffix: String? = nil
    let tm: String
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try values.decodeIfPresent(String.self, forKey: .name)!.folding(options: .diacriticInsensitive, locale: .current)
        // the playerid string must be trimmed from the carrage return character "\r" for it to not be present in the property
        self.playerid = try values.decodeIfPresent(String.self, forKey: .playerid)!.trimmingCharacters(in: .whitespacesAndNewlines)
        // if the team is blank then coalesce to FA
        let team = try values.decodeIfPresent(String.self, forKey: .tm) ?? "FA"
        self.tm = TeamConversion.convert(tm: team)
        let compsName = name.components(separatedBy: " ")
        self.firstName = compsName[0]
        self.lastName = compsName[1]
        if compsName.endIndex > 2 {
            self.suffix = compsName[2]
        }
    }
}

extension FangraphsPlayer {
    enum CodingKeys: String, CodingKey {
        case name = "Name"
        case tm = "Team"
        // since playerid is the last csv column the new line character is present
        case playerid = "playerid\r"
    }
}
