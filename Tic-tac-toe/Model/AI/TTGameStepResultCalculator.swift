//
//  TTGameStepResultCalculator.swift
//  Tic-tac-toe
//
//  Created by Dmytro Platov on 3/27/19.
//  Copyright © 2019 dplatov. All rights reserved.
//

public class TTGameStepResultCalculator {

    var maxDeep = 3
    public init() {}
    
    public func isLeadsToHumanWin(model: TTGameModel) -> Bool {
        
        return !stepAI(0, model)
    }
    
    fileprivate func stepHuman(_ step: Int, _ aiModel: TTGameModel) -> Bool {
        
        if (step < maxDeep) {
            
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
    
    fileprivate func stepAI(_ step: Int, _ humanModel: TTGameModel) -> Bool {
        
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
