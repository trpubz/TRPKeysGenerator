//
//  IO.swift
//  TRPKeysGenerator
//
//  Created by Taylor Pubins on 3/25/22.
//

import Foundation
import CodableCSV

class IO {
    private var decoder = CSVDecoder { $0.headerStrategy = .firstLine }
    
    func writeKeys(keys: [TempPlayer]) {
        let encoder: JSONEncoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            let jsonData: Data = try encoder.encode(keys)
            try jsonData.write(to: FileManager.urlKeysTRP)
            print("successful file write")
        } catch { fatalError("data conversion busted \(error)") }
    }
}

// MARK: - Load Pitchers
extension IO {
    func createFGPitchers() -> [FangraphsPlayer] {
        do {
            return try decoder.decode([FangraphsPlayer].self, from: FileManager.urlATCPitchers)
        } catch { fatalError("createFGHitters \(error)")}
    }
    
    func readerPitchers() -> CSVReader {
        do {
            let result = try CSVReader(input: FileManager.urlATCPitchers) {
                $0.encoding = .utf8
                $0.delimiters.row = "\r\n"
                $0.headerStrategy = .firstLine
                $0.trimStrategy = .whitespaces
            }
            return result
        } catch { fatalError("error with loadHitters \(error)") }
    }
}
// MARK: - Load Hitters
extension IO {
    /// Hitters from Fangraphs projections
    func readerHitters() -> CSVReader {
        do {
            let reader = try CSVReader(input: FileManager.urlATCHitters) {
                $0.encoding = .utf8
                $0.delimiters.row = "\r\n"
                $0.headerStrategy = .firstLine
                $0.trimStrategy = .whitespaces
            }
            return reader
        } catch { fatalError("error with loadHitters \(error)") }
    }
    
    func createFGHitters() -> [FangraphsPlayer] {
        do {
            return try decoder.decode([FangraphsPlayer].self, from: FileManager.urlATCHitters)
        } catch { fatalError("createFGHitters \(error)")}
    }
}

// MARK: - Load ESPN Players
extension IO {
    /// Loads the ESPN Players json file and parses it into Player objects
    ///
    /// - Returns: an array of parsed Player objects
    ///
    func loadESPNPlayers() -> [TempPlayer] {
        let jDecoder = JSONDecoder()
        do {
            return try jDecoder.decode([TempPlayer].self, from: .init(contentsOf: FileManager.urlESPNPlayerData))
        } catch { fatalError("error with loadESPNPlayers \(error)") }
    }
}

