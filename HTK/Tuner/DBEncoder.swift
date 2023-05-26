//
//  DBEncoder.swift
//  LoadJsonToSQLite
//
//  Created by HarmonicaToolkit on 17/01/2023.
//

import Foundation


class DBFileLoader {
    
    static func readLocalFile(_ filename: String) -> Data? {
        print (Bundle.main)
        guard let file = Bundle.main.path(forResource: filename, ofType: "json")
            else {
                fatalError("Unable to locate file \"\(filename)\" in main bundle.")
        }
        
        do {
            return try String(contentsOfFile: file).data(using: .utf8)
        } catch {
            fatalError("Unable to load \"\(filename)\" from main bundle:\n\(error)")
        }
    }
}
