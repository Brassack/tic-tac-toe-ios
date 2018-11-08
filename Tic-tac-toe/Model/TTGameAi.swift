//
//  TTGameAi.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 3/1/17.
//  Copyright © 2017 dplatov. All rights reserved.
//

import UIKit

class TTGameAI {
    
    static let maxDeep = 3
    
    func bestMove(for model: TTGameModel) -> (row:Int, column:Int) {
        
        for index in 0..<model.field.count {
            if model.field[index] == .none {
            
                var testModel = model
                testModel.field[index] = .o;
                
                if testModel.state == .loose {
                    return TTGameFieldIndexConverter.rowAndColumnFor(index: index)
                }
            }
        }
        
        for index in 0..<model.field.count {
            
            if model.field[index] == .none {
            
                var testModel = model
                testModel.field[index] = .o;
            
                if stepAI(0, testModel) {
                    return TTGameFieldIndexConverter.rowAndColumnFor(index: index)
                }
            }
        }

        return TTGameFieldIndexConverter.rowAndColumnFor(index: model.field.index(of:.none)!)
    }
    
    func stepHuman(_ step: Int, _ aiModel: TTGameModel) -> Bool {
        
        if (step < TTGameAI.maxDeep) {
        
            for index in 0..<aiModel.field.count {
            
                if aiModel.field[index] == .none {
                
                    var testModel = aiModel
                    testModel.field[index] = .o;
                
                    if testModel.state == .loose {
                        return true
                    }
                
                    if stepAI(step, testModel) {
                        return true;
                    }
                }
            }
            
            for index in 0..<aiModel.field.count {
                
                if aiModel.field[index] == .none {
                    return false
                }
            }
        }
        return true;
    }
    
    func stepAI(_ step: Int, _ humanModel: TTGameModel) -> Bool {
        
         for index in 0..<humanModel.field.count {
             
             if humanModel.field[index] == .none {
                
                var testModel = humanModel
                testModel.field[index] = .x;
                 
                 if testModel.state == .win {
                     return false;
                 }
             }
         }
         
         for index in 0..<humanModel.field.count {
             
             if humanModel.field[index] == .none {
                
                var testModel = humanModel
                testModel.field[index] = .x;
                 
                 if !stepHuman(step + 1, testModel) {
                     return false;
                 }
             }
        }
        
        return true;
    }
}
