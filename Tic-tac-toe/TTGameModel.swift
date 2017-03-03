//
//  TTGameModel.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 3/1/17.
//  Copyright © 2017 dplatov. All rights reserved.
//

import UIKit

enum TTGameFigure {
    case none
    case x
    case o
}

enum TTGameState {
    case game
    case win
    case loose
    case draw
}

class TTGameModel: NSObject {
    static let sharedModel:TTGameModel = TTGameModel()
    
    var field:[TTGameFigure] = [TTGameFigure.none, TTGameFigure.none, TTGameFigure.none,
                                TTGameFigure.none, TTGameFigure.none, TTGameFigure.none,
                                TTGameFigure.none, TTGameFigure.none, TTGameFigure.none]
    
    func resetModel() {
        for index in 0..<field.count{
            field[index] = TTGameFigure.none
        }
    }
    
    func put(figure:TTGameFigure, intoRow row:Int, intoColumn column:Int) {
        field[TTGameModel.indexFor( row, column)] = figure
    }
    
    func figureAt(_ row:Int, _ column:Int) -> TTGameFigure {
        return field[TTGameModel.indexFor(row,column)]
    }
    
    func currentState() -> TTGameState {
        return self.state(forField:self.field)
    }
    
    func state(forField field: [TTGameFigure]) -> TTGameState {
        
        /*---
          -×-
          --- */
        var testingElement = field[TTGameModel.indexFor(2,2)]
        
        func result() -> TTGameState{
            if(testingElement == TTGameFigure.o){
                return TTGameState.loose
            }else{
                return TTGameState.win
            }
        }
        
        if(testingElement != TTGameFigure.none){
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
            if(field[TTGameModel.indexFor(0,1)] == testingElement
                && field[TTGameModel.indexFor(2,1)] == testingElement){
                return result()
            }
            /*--?
              -×-
              ?-- */
            if(field[TTGameModel.indexFor(0,2)] == testingElement
                && field[TTGameModel.indexFor(2,0)] == testingElement){
                return result()
            }
            
            /*---
              ?×?
              --- */
            if(field[TTGameModel.indexFor(1,0)] == testingElement
                && field[TTGameModel.indexFor(1,2)] == testingElement){
                return result()
            }
        }
        
        /*-×-
          ---
          --- */
        testingElement = field[TTGameModel.indexFor(2,2)]
        
        if(testingElement != TTGameFigure.none){
            /*?×?
              ---
              --- */
            if(field.first == testingElement
                && field[TTGameModel.indexFor(0,1)] == testingElement){
                return result()
            }
        }
        
        /*---
          ×--
          --- */
        testingElement = field[TTGameModel.indexFor(1,0)]
        
        if(testingElement != TTGameFigure.none){
            /*?--
              ×--
              ?-- */
            if(field.first == testingElement
                && field[TTGameModel.indexFor(2,0)] == testingElement){
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
        testingElement = field[TTGameModel.indexFor(1,0)]
        
        if(testingElement != TTGameFigure.none){
            /*--?
              --×
              --? */
            if(field[TTGameModel.indexFor(0,2)] == testingElement
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
        testingElement = field[TTGameModel.indexFor(1,0)]
        
        if(testingElement != TTGameFigure.none){
            /*---
              ---
              ?×? */
            if(field[TTGameModel.indexFor(2,0)] == testingElement
                && field.last == testingElement){
                return result()
            }
            /*-?-
              -?-
              -×- */
            //already tested
        }
        
        
        if(field.index(of:TTGameFigure.none) == NSNotFound){
            return TTGameState.draw
        }
        
        return TTGameState.game
    }
    
    static func indexFor(_ row:Int, _ column:Int) -> Int{
        return 3*row + column
    }
    
    static func rowAndColumnFor(index:Int) -> (row:Int, column:Int){
        let row = index/3
        let column = index - row*3
        
        return (row, column)
    }
    
    static func numberFor(_ field:[TTGameFigure]) -> Int32 {

        var number:Int32 = 0b0
    
        for index in 0..<field.count{
            let figure = field[index]
            var figureNumber:Int32
            switch figure {
            case .none:
                figureNumber = 0b00
            case .x:
                figureNumber = 0b01
            case .o:
                figureNumber = 0b10
            }
            
            figureNumber = figureNumber << Int32(2*index)
            
            number = number | figureNumber
            
        }
        
        return number
    }
    
    static func fieldForNumber(_ number:Int32) ->[TTGameFigure]{
    
        var field:[TTGameFigure] = [TTGameFigure]()
        
        for index:Int32 in 0 ..< 9{
            
            let mask:Int32 = 0b11 << (index*2)
            
            let figureCode = (number & mask) >> (index*2)
            
            if(figureCode == 0b00){
                field.append(TTGameFigure.none)
            }else if(figureCode == 0b01){
                field.append(TTGameFigure.x)
            }else if(figureCode == 0b10){
                field.append(TTGameFigure.o)
            }            
        }
    
        return field
    }
}
