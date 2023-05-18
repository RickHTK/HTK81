//
//  QueueStruct.swift
//  HarmonicaToolkit
//
//  Created by HarmonicaToolkit on 16/05/2023.
//

import Foundation


struct Queue<T> {
  private var elements: [T] = []

  mutating func enqueue(_ value: T) {
    elements.append(value)
      if elements.count > 10 {
          self.dequeue()
      }
    print ("Q Elements: ", elements)
      
  }

  mutating func dequeue() -> T? {
    guard !elements.isEmpty else {
      return nil
    }
    return elements.removeFirst()
  }

  var head: T? {
    return elements.first
  }

  var tail: T? {
    return elements.last
  }
}


//struct RingBufferQueue<T>: CustomStringConvertible {
struct RingBufferQueue {
    
    
    class elementSustainedLength {
        init (ElementFound: Int, SustainedLength : Int) {
            elementFound = ElementFound
            sustainedLength  = SustainedLength
        }
        var elementFound : Int
        var sustainedLength : Int
    }
    
    private var elements: [Int]
    
    var lastMatchedElements : [Int] = [0]
    var lastMatchedElementSustainedLength : [elementSustainedLength] = [elementSustainedLength(ElementFound: 0,SustainedLength: 0)]
    
    private var front = 1
    private var rear = 0
    
    init (count : Int) {
        elements = Array (repeating: 0, count: count)
    }
    
    var isEmpty: Bool {
        front == -1 && rear == -1
    }
    
    var isFull: Bool {
        ((rear + 1) % elements.count) == front
    }
    
    var numberOfElements : Int {
        return  elements.count
        
    }
    
    var peek : Int {
        if isEmpty {
            print ("EMPTY Q", elements)
            return 0
        }
        
        return elements [front]
        
    }
    
    mutating func enqueue (_ element: Int) -> Bool {
        if front == -1 && rear == -1 {
            front = 0
            rear = 0
            elements [rear] = element
            return true
        }
        if isFull {

            front = (front + 1) % elements.count
            rear = (rear + 1) % elements.count
            
            elements [rear] = element
            print ("FULL Elements ", elements, "front: ", front, "rear: ", rear)
            
 
            
            
            
            return false
        }
        rear = (rear + 1) % elements.count
        //elements[rear] = element
        return true
    }
    
    func returnRear (numberOfElements: Int) -> [Int] {
        var rearElements : [Int] = []
        for element in 0 ... numberOfElements - 1 {
            rearElements.append(elements[(rear + elements.count - element) % elements.count])
        }
        return rearElements
        
    }
    

    
    func peekLastThree () {
        print (numberOfElements)
        
        print (elements)
        
        
        
        if numberOfElements > 2 {
            print ("Elements front 3: ", elements[front], elements [(front + elements.count - 1) % elements.count], elements [(front + elements.count - 2) % elements.count])
        }
    }
    
    mutating func analyseLastElements (numberOfElements: Int) {
        let lastElements = returnRear(numberOfElements: numberOfElements)
        let lastMatched = lastMatchedElements [lastMatchedElements.count - 1]
        if lastMatched != lastElements [0]  &&  Set(lastElements).count == 1 {
            lastMatchedElements.append(lastElements [0])
            print ("ADDED: ", lastElements [0])
        }
        return
        
    }
    
    mutating func analyseLastElementSustainLengths (numberOfElements: Int) {
        let lastElements = returnRear(numberOfElements: numberOfElements)
        let lastMatched = lastMatchedElementSustainedLength[lastMatchedElementSustainedLength.count - 1].elementFound

        if Set(lastElements).count == 1 {
            if lastMatched != lastElements [0] {
                print ("last matched: ", lastMatched, "elements : ", lastElements)
                lastMatchedElementSustainedLength.append(elementSustainedLength(ElementFound: lastElements [0],SustainedLength: 3) )
                print ("ADDED: ", lastMatchedElementSustainedLength.last?.sustainedLength)
            }
            else {
                
                lastMatchedElementSustainedLength.last?.sustainedLength += 1
                print ("Incremented: " , lastMatchedElementSustainedLength.last?.sustainedLength)
            }
        }
        //return
    }
    
    
    
    /*
    func peekLastFour () -> [Int] {
        let frontFour : [Int] =
        [
        elements[front],
        elements [(front + elements.count - 1) % elements.count],
        elements [(front + elements.count - 2) % elements.count],
        elements [(front + elements.count - 3) % elements.count]
        ]
        
        
        
        print ("Elements front 2: ", elements[front], elements [(front + elements.count - 1) % elements.count], elements [(front + elements.count - 2) % elements.count])
        
        return []
    }*/
    
    func peekLastPlayed (sustainRequirement : Int) {
        for distanceFromRear in 0 ... sustainRequirement {
            print (elements [(front + elements.count - distanceFromRear) % elements.count])
        }
    }
    
    func peekLastSustained ()
    {
        var foundDifferentSustainedNote : Bool = false
        while !foundDifferentSustainedNote {
            
            
            
            
            foundDifferentSustainedNote = true
        }
    }
    
    
}
