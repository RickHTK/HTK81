//
//  TestCircularQueue.swift
//  HarmonicaToolkitTests
//
//  Created by HarmonicaToolkit on 17/05/2023.
//

import XCTest
@testable import HarmonicaToolkit

final class TestCircularQueue: XCTestCase {
    
    var notesDetectedQueue = RingBufferQueue(bufferSize: 20, bufferSensitivity: 3)

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

        //notesDetectedQueue.peekLastThree()
        
        
        
    }
    
    func testRingBufferQueueCapturesSixElements () throws {
        var x = RingBufferQueue(bufferSize: 6, bufferSensitivity: 3)
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
        var x = SimpleRingBufferQueue(bufferSize: 6)

        x.enqueue(1)
        x.analyseLastElements(changeSensitivity: 3)
        x.enqueue(2)
        x.analyseLastElements(changeSensitivity: 3)
        x.enqueue(2)
        x.analyseLastElements(changeSensitivity: 3)
        x.enqueue(2)
        x.analyseLastElements(changeSensitivity: 3)
        x.enqueue(3)
        x.analyseLastElements(changeSensitivity: 3)
        x.enqueue(3)
        x.analyseLastElements(changeSensitivity: 3)
        x.enqueue(3)
        x.analyseLastElements(changeSensitivity: 3)
        x.enqueue(4)
        x.analyseLastElements(changeSensitivity: 3)
        x.enqueue(4)
        x.analyseLastElements(changeSensitivity: 3)
        

        XCTAssertTrue(x.lastMatchedElements == [0,2,3])
        
    }
    
    func testRingBufferQueueSize3 () throws {
        var x = RingBufferQueue(bufferSize: 6, bufferSensitivity: 3)

        x.enqueue(2)
        x.analyseLastElementSustainLengths()
        x.enqueue(2)
        x.analyseLastElementSustainLengths()
        x.enqueue(2)
        x.analyseLastElementSustainLengths()
        x.enqueue(2)
        x.analyseLastElementSustainLengths()
        x.enqueue(2)
        x.analyseLastElementSustainLengths()
        x.enqueue(2)
        x.analyseLastElementSustainLengths()
        x.enqueue(3)
        x.analyseLastElementSustainLengths()
        x.enqueue(4)
        x.analyseLastElementSustainLengths()
        x.enqueue(4)
        x.analyseLastElementSustainLengths()
        
        for i in x.lastMatchedElements {
            print (i.elementFound, i.elementRepeated)
        }

        //XCTAssertTrue(x.lastMatchedElements == [0,2,3])
        
    }
    
    func testRingBufferQueueSize4 () throws {
        
        let testBufferSize : Int = 10
        let testBufferSensitivity : Int = 4
        
        var x = RingBufferQueue(bufferSize: testBufferSize, bufferSensitivity: testBufferSensitivity)

        x.enqueue(2)
        x.analyseLastElementSustainLengths()
        x.enqueue(2)
        x.analyseLastElementSustainLengths()
        x.enqueue(3)
        x.analyseLastElementSustainLengths()
        x.enqueue(3)
        x.analyseLastElementSustainLengths()
        x.enqueue(3)
        x.analyseLastElementSustainLengths()
        x.enqueue(4)
        x.analyseLastElementSustainLengths()
        x.enqueue(4)
        x.analyseLastElementSustainLengths()
        x.enqueue(4)
        x.analyseLastElementSustainLengths()
        x.enqueue(4)
        x.analyseLastElementSustainLengths()
        x.enqueue(5)
        x.analyseLastElementSustainLengths()
        x.enqueue(5)
        x.analyseLastElementSustainLengths()
        x.enqueue(5)
        x.analyseLastElementSustainLengths()
        x.enqueue(5)
        x.analyseLastElementSustainLengths()
        x.enqueue(5)
        x.analyseLastElementSustainLengths()
        x.enqueue(1)
        x.analyseLastElementSustainLengths()
        x.enqueue(2)
        x.analyseLastElementSustainLengths()
        x.enqueue(2)
        x.analyseLastElementSustainLengths()
       
        
        for i in x.lastMatchedElements {
            print (i.elementFound, i.elementRepeated)
            XCTAssertTrue( !(i.elementRepeated < testBufferSensitivity))
            
        }

        //XCTAssertTrue(x.lastMatchedElements == [0,2,3])
    }
    
     func testRingBufferQueueSizeVariable () throws {
         
         let testBufferSize : Int = 4
         let testBufferSensitivity : Int = 4
         
         var x = RingBufferQueue(bufferSize: testBufferSize, bufferSensitivity: testBufferSensitivity)

         /// enqueue the same notes repeatedly more and more times
         for i in 1 ... 10 {
             for j in 1 ... i {
                 print (i,j)
                 x.enqueue(i)
                 x.analyseLastElementSustainLengths()
             }
         }

         
         for i in x.lastMatchedElements {
             print (i.elementFound, i.elementRepeated)
             
             /// check if an element that has been enqueued less that the buffer sensitivity appears in the results
             XCTAssertTrue( !(i.elementRepeated < testBufferSensitivity))
             
         }

         //XCTAssertTrue(x.lastMatchedElements == [0,2,3])
     }
    
     func testRingBufferBufferSizeVariable () throws {
         
         let testBufferSize : Int = 4
         let testBufferSensitivity : Int = 4
         
         var x = RingBufferQueue(bufferSize: testBufferSize, bufferSensitivity: testBufferSensitivity)

         /// enqueue the same notes repeatedly more and more times
         for i in 1 ... 10 {
             for j in 1 ... i {
                 print (i,j)
                 x.enqueue(i)
                 x.analyseLastElementSustainLengths()
             }
         }

         
         for i in x.lastMatchedElements {
             print (i.elementFound, i.elementRepeated)
             
             /// check if an element that has been enqueued less that the buffer sensitivity appears in the results
             XCTAssertTrue( !(i.elementRepeated < testBufferSensitivity))
             
         }

         //XCTAssertTrue(x.lastMatchedElements == [0,2,3])
     }
     
}
