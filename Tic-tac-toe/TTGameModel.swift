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
        field[TTGameModel.indexFor(row: row, column: column)] = figure
    }
    
    func figureAt(_ row:Int, _ column:Int) -> TTGameFigure {
        return field[TTGameModel.indexFor(row: row, column: column)]
    }
    
    func currentState() -> TTGameState {
        return TTGameState.game
    }
    
    static func indexFor(row:Int, column:Int) -> Int{
        return 3*row + column
    }
    
    static func rowAndColumnFor(index:Int) -> (row:Int, column:Int){
        let row = index/3
        let column = index - row*3
        
        return (row, column)
    }
    
    static func numberFor(_ field:[TTGameFigure]) -> Int32 {
        print("field \(field)")
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
//        print("number after \(String(number, radix: 2))")
         print("field decoded \(self.fieldForNumber(number))")

        
        return number
    }
    
    static func fieldForNumber(_ number:Int32) ->[TTGameFigure]{
    
//        figureNumber = 0b00
        var field:[TTGameFigure] = [TTGameFigure]()
        
        for index:Int32 in 0 ..< 9{

        }
    
        return field
    }
    
}
