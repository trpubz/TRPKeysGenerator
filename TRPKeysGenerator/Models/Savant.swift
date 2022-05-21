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
    
    required init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.firstName = try values.decodeIfPresent(String.self, forKey: .firstName)!.folding(options: .diacriticInsensitive, locale: .current).trimmingCharacters(in: .whitespaces)
        let lastName = try values.decodeIfPresent(String.self, forKey: .lastName)!.folding(options: .diacriticInsensitive, locale: .current).components(separatedBy: " ")
        self.playerid = try values.decodeIfPresent(String.self, forKey: .playerid)!.trimmingCharacters(in: .whitespacesAndNewlines)
        self.lastName = lastName[0]
        if lastName.endIndex > 1 {
            self.suffix = lastName[1]
        }
    }
}

extension SavantPlayer {
    enum CodingKeys: String, CodingKey {
        case firstName = " first_name"
        case lastName = "last_name"
        case playerid = "player_id"
    }
}
