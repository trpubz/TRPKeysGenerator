//
//  Teams.swift
//  TRPKeysGenerator
//
//  Created by Taylor Pubins on 3/25/22.
//

import Foundation

enum TeamConversion {

    /// Converts fangraphs team to EPSN team
    /// - parameter tm: the Fangraphs team string from Fangraphs csv
    /// - returns String representation of ESPN Universe Team ID
    
    static func convert(tm: String) -> String {
        switch tm {
        case "CHW": return "CWS"
        case "KCR": return "KC"
        case "SDP": return "SD"
        case "SFG": return "SF"
        case "TBR": return "TB"
        case "WSN": return "WSH"
        default: return tm
        }
//        return tm
    }
    
    // TODO: create conversion for Savant teams
}
