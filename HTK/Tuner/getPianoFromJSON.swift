//
//  getPianoFromJson.swift
//  HarmonicaToolkit
//
//  Created by HarmonicaToolkit on 10/05/2023.
//

import Foundation

class setupPiano {
    
    
    
    // var pianoKeyboard : [PianoKey]
    
    
    
    func getPianoFromJSON () -> [PianoKey] {
        
        
            
            //testdby = htkDB.openDatabase()
            guard let pianoStructure = DBFileLoader.readLocalFile("pianoNotes")
                else {
                    fatalError("Unable to locate file \"pianoNotes.json\" in main bundle.")
            }
            
            let rawPianokeys = DBFileLoader.loadPianoKeyboardJson(pianoStructure)


        return rawPianokeys.pianoKeys
        
        
    }
    
}
