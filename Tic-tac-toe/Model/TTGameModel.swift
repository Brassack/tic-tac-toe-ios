//
//  TTGameModel.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 3/1/17.
//  Copyright © 2017 dplatov. All rights reserved.
//


public struct TTGameModel {
    
    var indexConverter = TTGameFieldIndexConverter()
    public var field: [Figure] = [Figure](repeating: .none, count: 9)
    
    public init(){}
    
    mutating func reset() {
        field = [Figure](repeating: .none, count: field.count)
    }
    
    public mutating func put(_ figure: Figure, intoRow row: Int, column: Int) {
        field[indexConverter.indexFor(row, column)] = figure
    }
    
    public func figure(atRow row: Int, column: Int) -> Figure {
        return field[indexConverter.indexFor(row, column)]
    }
    
    public var description: String {
        get{
            return "\n┌───┐\n"
                + "│\(field[0].rawValue)\(field[1].rawValue)\(field[2].rawValue)│\n"
                + "│\(field[3].rawValue)\(field[4].rawValue)\(field[5].rawValue)│\n"
                + "│\(field[6].rawValue)\(field[7].rawValue)\(field[8].rawValue)│\n"
                + "└───┘"
        }
    }
    public var state: State {
        get {
            
            /*---
             -×-
             --- */
            var testingElement = field[indexConverter.indexFor(1, 1)]
            
            func result() -> State {
                if(testingElement == Figure.o){
                    return .loose
                }else{
                    return .win
                }
            }
            
            if(testingElement != .none){
                /*?--
                 -×-
                 --? */
                if(field.first == testingElement
                    && field.last == testingElement){
                    
                    return result()
                }
                /*-?-
                 -×-
                 -?- */
                if(field[indexConverter.indexFor(0, 1)] == testingElement
                    && field[indexConverter.indexFor(2, 1)] == testingElement){
                    return result()
                }
                /*--?
                 -×-
                 ?-- */
                if(field[indexConverter.indexFor(0, 2)] == testingElement
                    && field[indexConverter.indexFor(2, 0)] == testingElement){
                    return result()
                }
                
                /*---
                 ?×?
                 --- */
                if(field[indexConverter.indexFor(1, 0)] == testingElement
                    && field[indexConverter.indexFor(1, 2)] == testingElement){
                    return result()
                }
            }
            
            /*-×-
             ---
             --- */
            testingElement = field[indexConverter.indexFor(0, 1)]
            
            if(testingElement != .none){
                /*?×?
                 ---
                 --- */
                if(field.first == testingElement
                    && field[indexConverter.indexFor(0, 2)] == testingElement){
                    return result()
                }
            }
            
            /*---
             ×--
             --- */
            testingElement = field[indexConverter.indexFor(1, 0)]
            
            if(testingElement != .none){
                /*?--
                 ×--
                 ?-- */
                if(field.first == testingElement
                    && field[indexConverter.indexFor(2, 0)] == testingElement){
                    return result()
                }
                
                /*---
                 ×??
                 --- */
                //already tested
            }
            
            /*---
             --×
             --- */
            testingElement = field[indexConverter.indexFor(1, 2)]
            
            if(testingElement != .none){
                /*--?
                 --×
                 --? */
                if(field[indexConverter.indexFor(0, 2)] == testingElement
                    && field.last == testingElement){
                    return result()
                }
                /*---
                 ??×
                 --- */
                //already tested
            }
            
            /*---
             ---
             -×- */
            testingElement = field[indexConverter.indexFor(2, 1)]
            
            if(testingElement != .none){
                /*---
                 ---
                 ?×? */
                if(field[indexConverter.indexFor(2, 0)] == testingElement
                    && field.last == testingElement){
                    return result()
                }
                /*-?-
                 -?-
                 -×- */
                //already tested
            }
            
            
            if(field.index(of:.none) == nil){
                return .draw
            }
            
            return .game
        }
    }
}
