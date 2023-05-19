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
    
    
    class elementSustainedFor {
        init (ElementFound: Int, ElementRepeated : Int) {
            elementFound = ElementFound
            elementRepeated = ElementRepeated
        }
        var elementFound : Int
        var elementRepeated : Int
    }
    
    private var elements: [Int]
    private var sustainCheck : Int
    
    var lastMatchedElements : [elementSustainedFor] = [] //[elementSustainedFor(ElementFound: 0,ElementRepeated: 0)]
    
    private var front = 1
    private var rear = 0
    
    init (bufferSize : Int, bufferSensitivity : Int) {
        elements = Array (repeating: 0, count: bufferSize)
        sustainCheck = bufferSensitivity
        if bufferSensitivity > bufferSize
        {
            sustainCheck = bufferSize
        }
    }
    
    var isEmpty: Bool {
        lastMatchedElements.isEmpty
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
    
    

    
    mutating func analyseLastElementSustainLengths () {
        
        let lastElements = returnRear(numberOfElements: sustainCheck)
        var lastMatched : Int  = 0
        
        if !isEmpty
        {
            lastMatched = lastMatchedElements[lastMatchedElements.count - 1].elementFound
        }
        
        if Set(lastElements).count == 1 {
            if lastMatched != lastElements [0] {
                lastMatchedElements.append(elementSustainedFor(ElementFound: lastElements [0],ElementRepeated: sustainCheck) )
            }
            else {
                lastMatchedElements.last?.elementRepeated += 1
                
            }
            //return
        }
        
    }
        
/*
        
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
    }*/
    
}
    
struct SimpleRingBufferQueue {

    private var elements: [Int]
    
    var lastMatchedElements : [Int] = [0]

    
    private var front = 1
    private var rear = 0
    
    init (bufferSize : Int) {
        elements = Array (repeating: 0, count: bufferSize)
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
    
    
    
    mutating func analyseLastElements (changeSensitivity: Int) {
        let lastElements = returnRear(numberOfElements: numberOfElements)
        let lastMatched = lastMatchedElements [lastMatchedElements.count - 1]
        if lastMatched != lastElements [0]  &&  Set(lastElements).count == 1 {
            lastMatchedElements.append(lastElements [0])
            print ("ADDED: ", lastElements [0])
        }
        return
        
    }
    
}
