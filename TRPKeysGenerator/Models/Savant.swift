//
//  Savant.swift
//  TRPKeysGenerator
//
//  Created by Taylor Pubins on 5/20/22.
//

import Foundation

class SavantPlayer: Codable {
    let playerid: String
    let firstName: String
    let lastName: String
    var suffix: String? = nil
    let tm: String
    
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
        self.tm = try values.decodeIfPresent(String.self, forKey: .tm)!
    }
}

extension SavantPlayer {
    enum CodingKeys: String, CodingKey {
        case firstName = "FIRSTNAME"
        case lastName = "LASTNAME"
        case playerid = "MLBID"
        case tm = "TEAM"
    }
}
