//
//  Teams.swift
//  TRPKeysGenerator
//
//  Created by Taylor Pubins on 3/25/22.
//

import Foundation

enum MLBConversion {

    /// Converts fangraphs team to EPSN team
    /// - parameter tm: the Fangraphs team string from Fangraphs csv
    /// - returns String representation of ESPN Universe Team ID
    
    static func convertFG(tm: String) -> String {
        switch tm {
        case "CHW": return "CWS"
        case "KCR": return "KC"
        case "SDP": return "SD"
        case "SFG": return "SF"
        case "TBR": return "TB"
        case "WSN": return "WSH"
            
        case "N/A": return "FA"
        default: return tm
        }
    }
    
    static func convertSavant(tm: String) -> String {
        switch tm {
//        case "CHW": return "CWS"
//        case "KCR": return "KC"
//        case "SDP": return "SD"
//        case "SFG": return "SF"
//        case "TBR": return "TB"
        case "WAS": return "WSH"
            
        case "N/A": return "FA"
        default: return tm
        }
    }
}
