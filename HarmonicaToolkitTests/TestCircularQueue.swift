//
//  TestCircularQueue.swift
//  HarmonicaToolkitTests
//
//  Created by HarmonicaToolkit on 17/05/2023.
//

import XCTest
@testable import HarmonicaToolkit

final class TestCircularQueue: XCTestCase {
    
    var notesDetectedQueue = RingBufferQueue(count: 20)

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAddElement() throws {

        notesDetectedQueue.enqueue(0)
        
        
    }
    
    func testPeekEmptyQueue() throws {

        notesDetectedQueue.peek
        
        
        
    }
    
    func testPeekLastThree() throws {
        
        notesDetectedQueue.enqueue(2)
        notesDetectedQueue.enqueue(3)
        notesDetectedQueue.enqueue(4)

        notesDetectedQueue.peekLastThree()
        
        
        
    }
    
    func testRingBufferQueueCapturesSixElements () throws {
        var x = RingBufferQueue(count: 6)
        print (x.peek)
        x.enqueue(1)
        print (x.peek)
        print (x.returnRear(numberOfElements: 3))
        x.enqueue(2)
        print (x.peek)
        print (x.returnRear(numberOfElements: 3))
        x.enqueue(3)
        print (x.peek)
        print (x.returnRear(numberOfElements: 3))
        

        x.enqueue(4)
        print (x.peek)
        print (x.returnRear(numberOfElements: 3))
        x.enqueue(5)
        print (x.peek)
        print (x.returnRear(numberOfElements: 3))
        x.enqueue(6)
        print (x.peek)
        print (x.returnRear(numberOfElements: 3))
    

        x.enqueue(7)
        print (x.peek)
        print (x.returnRear(numberOfElements: 3))
        x.enqueue(8)
        print (x.peek)
        print (x.returnRear(numberOfElements: 3))
        x.enqueue(9)
        print (x.peek)
        print (x.returnRear(numberOfElements: 3))
        
    }
    
    func testRingBufferQueueAnalysesChanges () throws {
        var x = RingBufferQueue(count: 6)

        x.enqueue(1)
        x.analyseLastElements(numberOfElements: 3)
        x.enqueue(2)
        x.analyseLastElements(numberOfElements: 3)
        x.enqueue(2)
        x.analyseLastElements(numberOfElements: 3)
        x.enqueue(2)
        x.analyseLastElements(numberOfElements: 3)
        x.enqueue(3)
        x.analyseLastElements(numberOfElements: 3)
        x.enqueue(3)
        x.analyseLastElements(numberOfElements: 3)
        x.enqueue(3)
        x.analyseLastElements(numberOfElements: 3)
        x.enqueue(4)
        x.analyseLastElements(numberOfElements: 3)
        x.enqueue(4)
        x.analyseLastElements(numberOfElements: 3)
        

        XCTAssertTrue(x.lastMatchedElements == [0,2,3])
        
    }
    
    func testRingBufferQueue () throws {
        var x = RingBufferQueue(count: 6)

        x.enqueue(2)
        x.analyseLastElementSustainLengths(numberOfElements: 3)
        x.enqueue(2)
        x.analyseLastElementSustainLengths(numberOfElements: 3)
        x.enqueue(2)
        x.analyseLastElementSustainLengths(numberOfElements: 3)
        x.enqueue(2)
        x.analyseLastElementSustainLengths(numberOfElements: 3)
        x.enqueue(2)
        x.analyseLastElementSustainLengths(numberOfElements: 3)
        x.enqueue(2)
        x.analyseLastElementSustainLengths(numberOfElements: 3)
        x.enqueue(3)
        x.analyseLastElementSustainLengths(numberOfElements: 3)
        x.enqueue(4)
        x.analyseLastElementSustainLengths(numberOfElements: 3)
        x.enqueue(4)
        x.analyseLastElementSustainLengths(numberOfElements: 3)
        

        //XCTAssertTrue(x.lastMatchedElements == [0,2,3])
        
    }
   

    
}
