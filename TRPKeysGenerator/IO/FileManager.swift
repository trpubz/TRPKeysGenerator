//
//  FileManager.swift
//  TRPKeysGenerator
//
//  Created by Taylor Pubins on 3/25/22.
//

import Foundation

struct FileManager {
    /// Global Constants
    private static let keysTRP: String = "keysTRP.json"
    private static let jsonESPNPlayer: String = "espnTopPlayers.json"
    private static let csvATCHitters: String = "atcHitters.csv"
    private static let csvATCPitchers: String = "atcPitchers.csv"
    private static let csvSteamerrBat: String = "steamerr_bat.csv"
    private static let csvSteamerrPit: String = "steamerr_pit.csv"
    private static let csvSavantBat: String = "expected_statistics_hit.csv"
    private static let csvSavantPit: String = "expected_statistics_pit.csv"
    
    static let dirBaseballHQ: URL = URL(fileURLWithPath: "/Users/Shared/BaseballHQ/", isDirectory: true)
    static let dirPreSeason: URL = URL(fileURLWithPath: "/Users/Shared/BaseballHQ/preseason/", isDirectory: true)
    static let dirRegSeason: URL = URL(fileURLWithPath: "/Users/Shared/BaseballHQ/regseason/", isDirectory: true)
    
    static let urlESPNPlayerData: URL = dirBaseballHQ.appendingPathComponent(jsonESPNPlayer)
    static let urlATCHitters: URL = dirPreSeason.appendingPathComponent(csvATCHitters)
    static let urlATCPitchers: URL = dirPreSeason.appendingPathComponent(csvATCPitchers)
    static let urlSteamerrBat: URL = dirRegSeason.appendingPathComponent(csvSteamerrBat)
    static let urlSteamerrPit: URL = dirRegSeason.appendingPathComponent(csvSteamerrPit)
    static let urlSavantBat: URL = dirRegSeason.appendingPathComponent(csvSavantBat)
    static let urlSavantPit: URL = dirRegSeason.appendingPathComponent(csvSavantPit)
    static let urlKeysTRP: URL = dirBaseballHQ.appendingPathComponent(keysTRP)
}
