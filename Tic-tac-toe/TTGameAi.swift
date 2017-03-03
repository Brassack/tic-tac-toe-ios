//
//  TTGameAi.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 3/1/17.
//  Copyright © 2017 dplatov. All rights reserved.
//

import UIKit

class TTGameAI: NSObject {
    static let sharedAI = TTGameAI()
    static let maxDeep = 3
    
    func aiDecision() -> (row:Int, column:Int) {
        
        
        var field = TTGameModel.sharedModel.field
        
        
        for index in 0..<field.count {
//            print("in \(index)")
            if field[index] == TTGameFigure.none {
            
                field[index] = TTGameFigure.o;
            
                if TTGameModel.state(forField: field) == TTGameState.loose {
                    return TTGameModel.rowAndColumnFor(index: index)
                }
            
                field[index] = TTGameFigure.none;
            }
        }
        
        for index in 0..<field.count {
            
            if field[index] == TTGameFigure.none {
            
                field[index] = TTGameFigure.o;
            
                if stepAI(0, field) {
                    return TTGameModel.rowAndColumnFor(index: index)
                }
            
                field[index] = TTGameFigure.none
            }
        }

        return TTGameModel.rowAndColumnFor(index: field.index(of:TTGameFigure.none)!)
    }
    
    func stepHuman(_ step:Int, _ aiField:[TTGameFigure]) -> Bool {
        
        if (step < TTGameAI.maxDeep) {

            var field = aiField
        
        
            for index in 0..<field.count {
            
                if field[index] == TTGameFigure.none {
                
                    field[index] = TTGameFigure.o;
                
                    if TTGameModel.state(forField: field) == TTGameState.loose {
                        return true
                    }
                
                    if stepAI(step, field) {
                        return true;
                    }
                
                    field[index] = TTGameFigure.none;
                }
            }
            
            for index in 0..<field.count {
                
                if field[index] == TTGameFigure.none {
                    return false
                }
            }
        }
        return true;
    }
    
    func stepAI(_ step:Int, _ aiField:[TTGameFigure]) -> Bool {
        
        
        var field = aiField
        
         for index in 0..<field.count {
             
             if field[index] == TTGameFigure.none {
                 
                 field[index] = TTGameFigure.x;
                 
                 if TTGameModel.state(forField: field) == TTGameState.win {
                     return false;
                 }
                 
                 field[index] = TTGameFigure.none;
             }
         }
         
         
         for index in 0..<field.count {
             
             if field[index] == TTGameFigure.none {
                 
                 field[index] = TTGameFigure.x;
                 
                 if !stepHuman(step + 1, field) {
                     return false;
                 }
                 
                 field[index] = TTGameFigure.none
             }
        }
        
        return true;
    }
}
