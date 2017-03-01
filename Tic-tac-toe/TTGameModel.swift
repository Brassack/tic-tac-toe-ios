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
    
}
