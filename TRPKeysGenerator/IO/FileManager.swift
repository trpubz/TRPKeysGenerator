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
    static let dirBaseballHQ: URL = URL(fileURLWithPath: "/Users/Shared/Baseball HQ/", isDirectory: true)
    static let urlESPNPlayerData: URL = dirBaseballHQ.appendingPathComponent(jsonESPNPlayer)
    static let urlATCHitters: URL = dirBaseballHQ.appendingPathComponent(csvATCHitters)
    static let urlATCPitchers: URL = dirBaseballHQ.appendingPathComponent(csvATCPitchers)
    static let urlKeysTRP: URL = dirBaseballHQ.appendingPathComponent(keysTRP)
}
