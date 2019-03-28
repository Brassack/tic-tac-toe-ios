//
//  TTCalculationGameAI.swift
//  Tic-tac-toe
//
//  Created by Dmytro Platov on 3/27/19.
//  Copyright © 2019 dplatov. All rights reserved.
//

class TTCalculationGameAI: TTGameAI {

    var indexConverter = TTGameFieldIndexConverter()
    
    func bestMove(for model: TTGameModel) -> (row: Int, column: Int) {
        
        for index in 0..<model.field.count {
            if model.field[index] == .none {
                
                var testModel = model
                testModel.field[index] = .o;
                
                if testModel.state == .loose {
                    return indexConverter.rowAndColumnFor(index: index)
                }
            }
        }
        
        for index in 0..<model.field.count {
            
            if model.field[index] == .none {
                
                var testModel = model
                testModel.field[index] = .o;
                
                let calculator = TTGameStepResultCalculator()
                
                if !calculator.isLeadsToHumanWin(model: testModel){
                    return indexConverter.rowAndColumnFor(index: index)
                }

            }
        }
        
        return indexConverter.rowAndColumnFor(index: model.field.index(of:.none)!)
    }
}
