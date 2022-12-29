//
//  MockTunerConductorModel.swift
//  HarmonicaToolkitTests
//
//  Created by Richard Hardy on 28/12/2022.
//

import Foundation
@testable import HarmonicaToolkit

final class MockTunerConductor : TunerConductorModel {
    var data : TunerData = TunerData()
    public init() {}
    func start() {}
    func stop() {}
}
