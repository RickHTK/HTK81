//
//  setupParams.swift
//  HarmonicaToolkit
//
//  Created by Richard Hardy on 09/07/2022.
//

import Foundation
import SwiftUI




let harmonicaNames:[(   baseNote:           Int,
                        harmonicaName:      String,
                        harmonicaShortName: String,
                        firstPosition:      Int,
                        secondPosition:     Int,
                        thirdPosition:      Int,
                        fourthPosition:     Int,
                        fifthPosition:      Int,
                        sixthPosition:      Int,
                        seventhPosition:    Int,
                        eighthPosition:     Int,
                        ninthPosition:      Int,
                        tenthPosition:      Int,
                        eleventhPosition:   Int,
                        twelvthPosition:    Int
                    )

                    ] =
[ // should be calculated..
(23,    "Low G", "G",     11, 6,     1,   8,      3,      10,     5,      0,      7,      2,      9,      4),
(24,    "Low Ab", "Ab",   0,  7,     2,   9,      4,      11,     6,      1,      8,      3,      10,     5),
(25,    "Low A", "A",     1,  8,     3,   10,     5,      0,      7,      2,      9,      4,      11,     6),
(26,    "Low Bb", "Bb",   2,  9,     4,   11,     6,      1,      8,      3,      10,     5,      0,      7),
(27,    "Low B", "B",     3,  10,    5,   0,      7,      2,      9,      4,      11,     6,      1,      8),
(28,    "Low C", "C",     4,  11,    6,   1,      8,      3,      10,     5,      0,      7,      2,      9),
(29,    "Low C#", "C#",   5,  0,     7,   2,      9,      4,      11,     6,      1,      8,      3,      10),
(30,    "Low D", "D",     6,  1,     8,   3,      10,     5,      0,      7,      2,      9,      4,      11),
(31,    "Low Eb", "Eb",   7,  2,     9,   4,      11,     6,      1,      8,      3,      10,     5,      0),
(32,    "Low E", "E",     8,  3,     10,  5,      0,      7,      2,      9,      4,      11,     6,      1),
(33,    "Low F", "F",     9,  4,     11,  6,      1,      8,      3,      10,     5,      0,      7,      2),
(34,    "Low F#", "F#",   10, 5,     0,   7,      2,      9,      4,      11,     6,      1,      8,      3),
(35,    "G-Maj", "G",     11, 6,     1,   8,      3,      10,     5,      0,      7,      2,      9,      4),
(36,    "Ab-Maj", "Ab",   0,  7,     2,   9,      4,      11,     6,      1,      8,      3,      10,     5),
(37,    "A-Maj", "A",     1,  8,     3,   10,     5,      0,      7,      2,      9,      4,      11,     6),
(38,    "Bb-Maj", "Bb",   2,  9,     4,   11,     6,      1,      8,      3,      10,     5,      0,      7),
(39,    "B-Maj", "B",     3,  10,    5,   0,      7,      2,      9,      4,      11,     6,      1,      8),
(40,    "C-Maj", "C",     4,  11,    6,   1,      8,      3,      10,     5,      0,      7,      2,      9),
(41,    "C#-Maj", "C#",   5,  0,     7,   2,      9,      4,      11,     6,      1,      8,      3,      10),
(42,    "D-Maj", "D",     6,  1,     8,   3,      10,     5,      0,      7,      2,      9,      4,      11),
(43,    "Eb-Maj", "Eb",   7,  2,     9,   4,      11,     6,      1,      8,      3,      10,     5,      0),
(44,    "E-Maj", "E",     8,  3,     10,  5,      0,      7,      2,      9,      4,      11,     6,      1),
(45,    "F-Maj", "F",     9,  4,     11,  6,      1,      8,      3,      10,     5,      0,      7,      2),
(46,    "F#-Maj", "F#",   10, 5,     0,   7,      2,      9,      4,      11,     6,      1,      8,      3)
]


// The same dictionary in two senses.


let harmonicaBaseDict_DEL =
[ // should be calculated..
    "Low G" : -5,
    "Low Ab" :-4,
    "Low A" :-3,
    "Low Bb" : -2,
    "Low B" : -2,
    "Low C" : 0,
    "Low C#" : 1,
    "Low D" : 2,
    "Low Eb" : 3,
    "Low E" : 4,
    "Low F"  : 5,
    "Low F#" : 6,
    "G-Maj" : 7,
    "Ab-Maj" : 8,
    "A-Maj"  : 9,
    "Bb-Maj" : 10,
    "B-Maj" : 11,
    "C-Maj" : 17,
    "C#-Maj" : 13,
    "D-Maj" : 14,
    "Eb-Maj" : 15,
    "E-Maj" : 16,
    "F-Maj" : 17,
    "F#-Maj" : 18
]

let harmonicaBaseDict =
[ // should be calculated..
    "Low G" : 0,
    "Low Ab" : 1,
    "Low A" : 2,
    "Low Bb" : 3,
    "Low B" : 4,
    "Low C" : 5,
    "Low C#" : 6,
    "Low D" : 7,
    "Low Eb" : 8,
    "Low E" : 9,
    "Low F"  : 10,
    "Low F#" : 11,
    "G-Maj" : 12,
    "Ab-Maj" : 13,
    "A-Maj"  : 14,
    "Bb-Maj" : 15,
    "B-Maj" : 16,
    "C-Maj" : 17,
    "C#-Maj" : 18,
    "D-Maj" : 19,
    "Eb-Maj" : 20,
    "E-Maj" : 21,
    "F-Maj" : 22,
    "F#-Maj" : 23
]


let keyTypeDict =
[ // should be calculated..
    "Low G" : 1,
    "Low Ab" : 1,
    "Low A" : 1,
    "Low Bb" : 0,
    "Low B" : 1,
    "Low C" : 0,
    "Low C#" : 1,
    "Low D" : 1,
    "Low Eb" : 0,
    "Low E" : 1,
    "Low F"  : 1,
    "Low F#" : 1,
    "G-Maj" : 1,
    "Ab-Maj" : 0,
    "A-Maj"  : 1,
    "Bb-Maj" : 0,
    "B-Maj" : 1,
    "C-Maj" : 1,
    "C#-Maj" : 1,
    "D-Maj" : 1,
    "Eb-Maj" : 0,
    "E-Maj" : 1,
    "F-Maj" : 1,
    "F#-Maj" : 1
]

let freqRangeDict :  [String : (Float, Float)] =
[
"Low G": (92.49861,880.0),
"Low Ab": (97.99886,932.3275),
"Low A": (103.8262,987.7666),
"Low Bb": (110.0,1046.502),
"Low B": (116.5409,1108.731),
"Low C": (123.4708,1174.659),
"Low C#": (130.8128,1244.508),
"Low D": (138.5913,1318.51),
"Low Eb": (146.8324,1396.913),
"Low E": (155.5635,1479.978),
"Low F ": (164.8138,1567.982),
"Low F#": (174.6141,1661.219),
"G-Maj": (184.9972,1760.0),
"Ab-Maj": (195.9977,1864.655),
"A-Maj ": (207.6523,1975.533),
"Bb-Maj": (220.0,2093.005),
"B-Maj": (233.0819,2217.461),
"C-Maj": (246.9417,2349.318),
"C#-Maj": (261.6256,2489.016),
"D-Maj": (277.1826,2637.02),
"Eb-Maj": (293.6648,2793.826),
"E-Maj": (311.127,2959.955),
"F-Maj": (329.6276,3135.963),
"F#-Maj ": (349.2282,3322.438),
]





/*
struct keyboardButton  {
    var button : Int = 0; // button
    var offset : String? = nil; // offset
    var wingdings : String? = nil; // wingdings
    var background : String? = nil; // background
    var backColor : UIColor? = nil; // background
    var displayed : String? = nil; // displayed Y/N
    var textColor : String? = nil; // Text Colour
    var foreColor : UIColor? = nil; // Text Colour
    var boilerplate : String? = nil; // Text displayed
    var buttonLabel : String? = nil; // Text displayed
    var fontSize : Int = 10; // text size
    
    init (
            i_button: Int,
            i_offset: String,
            i_wingdings : String,
            i_background : String,
            i_backColor : UIColor,
            i_displayed : String,
            i_textColor : String,
            i_foreColor : UIColor,
            i_boilerplate : String,
            i_buttonLabel : String,
            i_fontSize : Int
    )
    {
        
        button = i_button
        offset = i_offset
        wingdings = i_wingdings
        background = i_background
        backColor = i_backColor
        displayed = i_displayed
        textColor = i_textColor
        foreColor = i_foreColor
        boilerplate = i_boilerplate
        buttonLabel = i_buttonLabel
        fontSize = i_fontSize
        
    }
    
}*/

class Notes {
    var pianoKey : Int? = nil; // pianoKey
    var noteNameSharps : String? = nil; // noteName
    var noteNameFlats : String? = nil; // noteName
    var noteName : String? = nil; // noteName
    var frequency : Float? = nil; // frequency
    var defaultAction : Int = 0
}


protocol Tuner {
    var pitch: Float {get}
    var amplitude: Float {get}
    var noteName : String {get}
    //var noteNameWithFlats : String {get}
}

struct TunerData : Tuner {
    var pitch: Float = 0.0
    var amplitude: Float = 0.0
    var noteName = "-"
    //var noteNameWithFlats = "-"
    var pianoKey : Int = 0
    //var noteHistory : [noteDetail] = []
    var lastNotes : [noteDetail] = []
}

struct TunerMonitorData : Tuner {
    var pitch: Float
    var amplitude: Float
    var noteName : String
    //var noteNameWithFlats :String
    var sustainedTime : Int
}


struct noteDetail{
    var note : String
    var sustainLength : Int
    var pianoKey : Int
}

var harmonicaList =
[ "Low G",
  "Low Ab",
  "Low A",
  "Low Bb",
  "Low B",
   "Low C",
  "Low C#",
  "Low D",
  "Low Eb",
  "Low E",
  "Low F",
  "Low F#",
  "G-Maj",
  "Ab-Maj",
  "A-Maj",
  "Bb-Maj",
  "B-Maj",
  "C-Maj",
  "C#-Maj",
  "D-Maj",
  "Eb-Maj",
  "E-Maj",
  "F-Maj",
  "F#-Maj"
]



struct harmonica
{   var               baseNote : Int = 40
    var               harmonicaName:      String = "C-Maj"
    var               harmonicaShortName: String = "C"
    var               firstPosition:      Int = 11
    var               secondPosition:     Int = 6
    var               thirdPosition:      Int = 1
    var               fourthPosition:     Int = 8
    var               fifthPosition:      Int = 3
    var               sixthPosition:      Int = 10
    var               seventhPosition:    Int = 5
    var               eighthPosition:     Int = 0
    var               ninthPosition:      Int = 7
    var               tenthPosition:      Int = 2
    var               eleventhPosition:   Int = 9
    var               twelvthPosition:    Int = 4
    
    init ()
    {
        let baseOffset = baseNote - 40
        
        firstPosition = (11 + baseOffset) % 12
        thirdPosition = (6 + baseOffset) % 12
        secondPosition = (1 + baseOffset) % 12
        fourthPosition = (8 + baseOffset) % 12
        fifthPosition = (3 + baseOffset) % 12
        sixthPosition = (10 + baseOffset) % 12
        seventhPosition = (5 + baseOffset) % 12
        eighthPosition = (0 + baseOffset) % 12
        ninthPosition = (7 + baseOffset) % 12
        tenthPosition = (2 + baseOffset) % 12
        eleventhPosition = (9 + baseOffset) % 12
        twelvthPosition = (4 + baseOffset) % 12
    }
}

var harmonicaList2  =
 [
    ("firstPosition", 1),
    ("secondPosition", 2),
    ("thirdPosition", 3),
    ("fourthPosition", 4),
    ("fifthPosition", 5),
    ("sixthPosition", 6),
    ("seventhPosition", 7) ,
    ("eighthPosition", 8),
    ("ninthPosition", 9),
    ("tenthPosition", 10),
    ("eleventhPosition", 11),
    ("twelvthPosition", 12)
]


let harmonicaDictRev =

[ 0 : "Low G",
  1 : "Low Ab",
  2 : "Low A",
  3 : "Low Bb",
  4 : "Low B",
  5 : "Low C",
  6 : "Low C#",
  7 : "Low D",
8 : "Low Eb",
9 : "Low E",
10 : "Low F",
11 : "Low F#",
12 : "G-Maj",
13 : "Ab-Maj",
14 : "A-Maj",
15 : "Bb-Maj",
16 : "B-Maj",
17 : "C-Maj",
18 : "C#-Maj",
19 : "D-Maj",
20 : "Eb-Maj",
21 : "E-Maj",
22 : "F-Maj",
23 : "F#-Maj"
]


// Returns an ordered list

func orderHarmonicaArray () -> [String] {
    var retArray : [String] = []
    for i in stride (from : 0, to:   23, by:  1)
{
    
    retArray.append (harmonicaDictRev[i] ?? "")
}
    //print (retArray)
    return retArray
}

func orderModeArray () -> [String] {
    var retArray : [String] = []
    for i in stride (from : 0, to:   6, by:  1)
{
    
    retArray.append (modeDictRev[i] ?? "")
}
    //print (retArray)
    return retArray
}



var harmonicaBaseKeys = orderHarmonicaArray()

var harmonicaModes = orderModeArray ()


let positionDict : [String : Int] =
 [
    "1st" : 0,
    "2nd" : 1,
    "3rd" : 2,
    "4th" : 3,
    "5th" : 4,
    "6th" : 5,
    "7th" : 6,
    "8th" : 7,
    "9th" : 8,
    "10th" : 9,
    "11th" : 10,
    "12th" : 11
]



//var positionKeys = Array(positionDict.keys.map{$0}) //.sorted()

var positionKeys =
["1st","2nd","3rd","4th", "5th", "6th", "7th", "8th", "9th", "10th", "11th", "12th"]


let modeDict : [String : Int] // Name, Index, Best Position
=
[
    
    "Major Key": 0,
    "Mixilodian" : 1,
    "Dorian": 2 ,
    "Aeolian": 3,
    "Phrygian" : 4,
    "Locrian" : 5,
    "Lydian" : 6
    
]



let modeKeys = [
               "Major Key",
               "Mixilodian",
               "Dorian",
               "Aeolian",
               "Phrygian",
               "Locrian",
               "Lydian"
]

let modeKeysMap = [
               "Major Key",
               "Mixilodian",
               "Dorian",
               "Aeolian",
               "Phrygian",
               "Locrian",
               "Dorian","Dorian","Dorian","Dorian","Dorian",
               "Lydian"
]

let defaultMode = ["Major Key"]

let modeDictRev : [Int : String] // Name, Index, Best Position
=
[
    0 : "Major Key",
    1 : "Mixilodian",
    2 : "Dorian",
    3 : "Aeolian",
    4: "Phrygian" ,
    5: "Locrian" ,
    6: "Lydian"
]

let registers = ["Low","High",""]


let registerDict : [ String : Int ]
=
[
    "Low" : -1,
    "High" : 0,
    "" : 98
]


/*
let modeKey2 : [String : (String, Int, Int)] // Name, Index, Best Position
=
[
    "Dorian":("Dorian",1,3),
    "Aeolian":("Aeolian",2,4)
    

]*/

let sustainLengths : [String]
= [
    "1" ,
    "2" ,
    "3" ,
    "4" ,
    "5"
]

let sustainSensitivityDict : [String: Int]
= [
    "1" : 1 ,
    "2" : 2 ,
    "3" : 3 ,
    "4" : 4 ,
    "5" : 5
]



var modeOffset : [Int: [Int]]
=
[ // Mixolodian 2nd, Dorian 3rd, Aeolian 4th, Phrygian 5th, Locrian 6th, Lydian 12th, Harmonic Minor
    0  : [0,     0,   0,    0,     0,      0,     0],
    1  : [0,     0,   0,  999,   999,      0,     0],
    2  : [0,     0,   0,   -1,    -1,      0,     0],
    3  : [0,   999, 999,   -1,    -1,      0,   999],
    4  : [0,    -1,  -1,   -1,    -1,      0,    -1],
    5  : [0,     0,   0,    0,     0,      1,     0],
    6  : [0,     0,   0,    0,   999,      999,   0],
    7  : [0,     0,   0,    0,    -1,      0,     0],
    8  : [0,     0, 999,  999,    -1,      -1,    0],
    9  : [0,     0,  -1,   -1,    -1,      0,     2],
    10 : [999, 999,  -1,   -1,    -1,      0,   999],
    11 : [-1,   -1,  -1,   -1,    -1,      0,    -1]
]



let notesBase = 23  //23 is the first note in the notes list G2 C4 is 17 semi-ones higher

let AUTO_PLIST_HARPDEF_PATH = Bundle.main.path(forResource: "richterHarmonica", ofType: "plist")

let AUTO_PLIST_HARPDICT_PATH = Bundle.main.path(forResource: "richterHarmonicaDict", ofType: "plist")

let AUTO_PLIST_NOTES_PATH = Bundle.main.path(forResource: "pianoNotes", ofType: "plist")



enum ads: Int {
    case AdsOn = 0
    case AdsOff = 1
}
