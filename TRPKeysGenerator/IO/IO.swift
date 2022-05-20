//
//  IO.swift
//  TRPKeysGenerator
//  Houses the IO objects and logic to load/read csvs and json
//  Created by Taylor Pubins on 3/25/22.
//

import Foundation
import CodableCSV

class IO {
    private var decoder = CSVDecoder {
        $0.headerStrategy = .firstLine
        $0.delimiters.row = "\n"
    }
    
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

// MARK: - Load FG Pitchers
extension IO {
    func createFGPitchers(from url: URL) -> [FangraphsPlayer] {
        do {
            return try decoder.decode([FangraphsPlayer].self, from: url)
        } catch { fatalError("createFGPitchers \(error)")}
    }
}
// MARK: - Load FG Hitters
extension IO {
    /// Hitters from Fangraphs projections
    func createFGHitters(from url: URL) -> [FangraphsPlayer] {
        do {
            return try decoder.decode([FangraphsPlayer].self, from: url)
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

