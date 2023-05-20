//
//  PitchHighlightsCorrectKeys.swift
//  HarmonicaToolkitTests
//
//  Created by Richard Hardy on 28/12/2022.
//

import XCTest
@testable import HarmonicaToolkit

class PitchHighlightsCorrectKeys: XCTestCase {

    var tunerConductor : (any TunerConductorModel)?
    var mockTunerConductor: MockTunerConductor!
    
    override func setUp ()  {
        mockTunerConductor = MockTunerConductor()
        tunerConductor = .init(mockTunerConductor)
    
    }

    func testTunerConductor()
    {
        XCTAssert(true)
    }
    
}
