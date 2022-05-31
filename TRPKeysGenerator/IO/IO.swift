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
    
    func writeKeys(keys: [TRPTempPlayer]) {
        let encoder: JSONEncoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys, .withoutEscapingSlashes]
        do {
            let jsonData: Data = try encoder.encode(keys)
            try jsonData.write(to: FileManager.urlKeysTRP)
            print("successful file write")
        } catch { fatalError("data conversion busted \(error)") }
    }
}

// MARK: - Load FG
extension IO {
    func createFGHitters(from url: URL) -> [TPFangraphsPlayer] {
        do {
            return try decoder.decode([TPFangraphsPlayer].self, from: url)
        } catch { fatalError("createFGHitters \(error)")}
    }
    func createFGPitchers(from url: URL) -> [TPFangraphsPlayer] {
        do {
            return try decoder.decode([TPFangraphsPlayer].self, from: url)
        } catch { fatalError("createFGPitchers \(error)")}
    }
}
// MARK: - Load Savant
extension IO {
//    func createSavantHitters(from url: URL) -> [SavantPlayer] {
//        do {
//            return try decoder.decode([SavantPlayer].self, from: url)
//        } catch { fatalError("createSavantHitters \(error)")}
//    }
//    
//    func createSavantPitchers(from url: URL) -> [SavantPlayer] {
//        do {
//            return try decoder.decode([SavantPlayer].self, from: url)
//        } catch { fatalError("createSavantPitchers \(error)")}
//    }
    
    func createSavantPlayers(from url: URL) -> [TPSavantPlayer] {
//        self.decoder.delimiters.row = "\r\n"
        do {
            return try decoder.decode([TPSavantPlayer].self, from: url)
        } catch { fatalError("createSavantPitchers \(error)")}
    }
}

// MARK: - Load ESPN Players
extension IO {
    /// Loads the ESPN Players json file and parses it into Player objects
    ///
    /// - Returns: an array of parsed Player objects
    ///
    func loadESPNPlayers() -> [TRPTempPlayer] {
        let jDecoder = JSONDecoder()
        do {
            return try jDecoder.decode([TRPTempPlayer].self, from: .init(contentsOf: FileManager.urlESPNPlayerData))
        } catch { fatalError("error with loadESPNPlayers \(error)") }
    }
}

