//
//  HarmonicaToolkitJsonLoadTests.swift
//  HarmonicaToolkitTests
//
//  Created by HarmonicaToolkit on 08/05/2023.
//

import XCTest
@testable import HarmonicaToolkit

final class HarmonicaToolkitJsonLoadTests: XCTestCase {



    //var htkDB : MiniDBMS = MiniDBMS()
    var testdby : OpaquePointer?
    var harmonicaKeyboard : [KeyboardRow] = []
   

    override func setUpWithError() throws {
        
        //testdby = htkDB.openDatabase()
        guard let harmonicaStructure = DBFileLoader.readLocalFile("richterHarmonica")
            else {
                fatalError("Unable to locate file \"richterHarmonica.json\" in main bundle.")
        }
        
        let rawHarmonica = DBFileLoader.loadHarmonicaStructureJson(harmonicaStructure)
        
        harmonicaKeyboard = rawHarmonica.keyboardRows
        
        print ("RAW H Type: " , type(of: rawHarmonica))
        print ("RAW I Type: " , type(of: rawHarmonica.instrument))
        print ("RAW KR Type: " , type(of: rawHarmonica.keyboardRows))
        
        
        for i in rawHarmonica.keyboardRows  {
            print ("KEYBOARD ROW TYPE: ", type(of: i), type(of: i.keyboardKeys))
            print ("KEYBOARD ROW: ", i)
            
            for j in i.keyboardKeys {
                print (j)
            }
        }

        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        
        
        var parameterlist : [Any] = []
        let a : Int = 0
        let b : String = "x"
        let c : Int = 1
        parameterlist.append(a)
        parameterlist.append(c)
        
        for i in harmonicaKeyboard {
            
            let tableForInsert = String (describing: type(of: i))
     
            for j in i.keyboardKeys {
                
                let tableForInsert = String (describing: type(of: j))
                var parameterList1 = [j.button,j.offset,j.wingdings,j.background,j.displayed,j.background,j.textColor] as [Any]
                
                //htkDB.upsertDataDictionaryTable(tableName: tableForInsert, parameterList: parameterList1)
            }
            let parameterList2 = [i.rowNumber ,i.rowName] as [Any]
            //htkDB.upsertDataDictionaryTable(tableName: tableForInsert, parameterList: parameterList2 )
        }
        

        
    }

}



