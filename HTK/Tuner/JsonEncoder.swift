//
//  JsonEncoder.swift
//  LoadJsonToSQLite
//
//  Created by HarmonicaToolkit on 05/01/2023.
//

import Foundation
import SwiftUI

enum harmonicaKeyboardDisplayType : Int, Codable {
    case nonPlaying
    case playable
    case boilerplate
    case history
    case playing
    case signature
}

/// Struct used to get Hole information from json.
/// Limited to codable data types
struct HarmonicaStructureCodable: Codable {
    var instrument : String
    var keyboardRows: [KeyboardRow]
    }

struct KeyboardRow:  Codable  {
    //init (updateDict: [String: Any]) {
        //rowNumber = (updateDict["rowNumber"] as? Int)!
    //}
        var rowNumber: Int = 0
        var rowName: String = ""
        var keyboardKeys: [KeyboardKey] = []
    }

    struct KeyboardKey:  Codable {
        let button, offset: Int
        var wingdings, background, textColor: String
        let boilerplate: String
        var displayed : harmonicaKeyboardDisplayType
    }

extension DBFileLoader {
    
    static func loadHarmonicaStructureJson(_ data: Data) -> HarmonicaStructureCodable {
        do {
            return try JSONDecoder().decode(HarmonicaStructureCodable.self, from: data)
        } catch {
            fatalError("Unable to decode  \"\(data)\" as \(HarmonicaStructureCodable.self):\n\(error)")
        }
    }
}


struct PianoKeyboard: Codable {
    var instrument : String
    var pianoKeys: [PianoKey]
    }

    struct PianoKey:  Codable {
        let pianoKey, defaultAction : Int
        let noteNameSharps, noteNameFlats : String
        let frequency : Double
    }


extension DBFileLoader {
    
    static func loadPianoKeyboardJson(_ data: Data) -> PianoKeyboard {
        do {
            return try JSONDecoder().decode(PianoKeyboard.self, from: data)
        } catch {
            fatalError("Unable to decode  \"\(data)\" as \(PianoKeyboard.self):\n\(error)")
        }
    }
}
