//
//  TTGameModel.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 3/1/17.
//  Copyright © 2017 dplatov. All rights reserved.
//

import UIKit


struct TTGameModel {
    
    var field: [TTGameFigure] = [TTGameFigure](repeating: .none, count: 9)
    
    mutating func reset() {
        field = [TTGameFigure](repeating: .none, count: field.count)
    }
    
    mutating func put(figure: TTGameFigure, intoRow row: Int, column: Int) {
        field[TTGameFieldIndexConverter.indexFor(row, column)] = figure
    }
    
    func figure(atRow row: Int, column: Int) -> TTGameFigure {
        return field[TTGameFieldIndexConverter.indexFor(row, column)]
    }
    
    var state: TTGameState {
        get {
            
            /*---
             -×-
             --- */
            var testingElement = field[TTGameFieldIndexConverter.indexFor(1, 1)]
            
            func result() -> TTGameState {
                if(testingElement == TTGameFigure.o){
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
                if(field[TTGameFieldIndexConverter.indexFor(0, 1)] == testingElement
                    && field[TTGameFieldIndexConverter.indexFor(2, 1)] == testingElement){
                    return result()
                }
                /*--?
                 -×-
                 ?-- */
                if(field[TTGameFieldIndexConverter.indexFor(0, 2)] == testingElement
                    && field[TTGameFieldIndexConverter.indexFor(2, 0)] == testingElement){
                    return result()
                }
                
                /*---
                 ?×?
                 --- */
                if(field[TTGameFieldIndexConverter.indexFor(1, 0)] == testingElement
                    && field[TTGameFieldIndexConverter.indexFor(1, 2)] == testingElement){
                    return result()
                }
            }
            
            /*-×-
             ---
             --- */
            testingElement = field[TTGameFieldIndexConverter.indexFor(0, 1)]
            
            if(testingElement != .none){
                /*?×?
                 ---
                 --- */
                if(field.first == testingElement
                    && field[TTGameFieldIndexConverter.indexFor(0, 2)] == testingElement){
                    return result()
                }
            }
            
            /*---
             ×--
             --- */
            testingElement = field[TTGameFieldIndexConverter.indexFor(1, 0)]
            
            if(testingElement != .none){
                /*?--
                 ×--
                 ?-- */
                if(field.first == testingElement
                    && field[TTGameFieldIndexConverter.indexFor(2, 0)] == testingElement){
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
            testingElement = field[TTGameFieldIndexConverter.indexFor(1, 2)]
            
            if(testingElement != .none){
                /*--?
                 --×
                 --? */
                if(field[TTGameFieldIndexConverter.indexFor(0, 2)] == testingElement
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
            testingElement = field[TTGameFieldIndexConverter.indexFor(2, 1)]
            
            if(testingElement != .none){
                /*---
                 ---
                 ?×? */
                if(field[TTGameFieldIndexConverter.indexFor(2, 0)] == testingElement
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
