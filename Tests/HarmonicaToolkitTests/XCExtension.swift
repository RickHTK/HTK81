//
//  XCExtension.swift
//  HarmonicaToolkitTests
//
//  Created by Richard Hardy on 11/09/2022.
//

import Foundation
import XCTest
import Combine


extension XCTestCase {
    func waitUntil<T: Equatable>(
        _ propertyPublisher: Published<T>.Publisher,
        equals expectedValue: T,
        timeout: TimeInterval = 10,
        file: StaticString = #file,
        line: UInt = #line
    ) {
        let expectation = expectation(
            description: "Awaiting value \(expectedValue)"
        )
        
        var cancellable: AnyCancellable?

        cancellable = propertyPublisher
            .dropFirst()
            .first(where: { $0 == expectedValue })
            .sink { value in
                XCTAssertEqual(value, expectedValue, file: file, line: line)
                cancellable?.cancel()
                expectation.fulfill()
            }

        waitForExpectations(timeout: timeout, handler: nil)
    }
}



