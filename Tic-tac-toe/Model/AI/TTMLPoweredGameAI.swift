//
//  TTGameAi.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 3/1/17.
//  Copyright © 2017 dplatov. All rights reserved.
//

class TTMLPoweredGameAI: TTGameAI {
    
    var indexConverter = TTGameFieldIndexConverter()
    var modelConverter = TTGameFileldConverter()
    var stepCostPredictor = MLStepCostPredictor()
    
    func bestMove(for model: TTGameModel) -> (row: Int, column: Int) {
        
        var step: (row: Int, column: Int)?
        var cost: Double = 0


        for row in 0..<3 {
            for column in 0..<3 {
                if model.figure(atRow: row, column: column) == .none {
                    
                    var testModel = model
                    testModel.put(.o, intoRow: row, column: column)
                    
                    if let predictions = try? stepCostPredictor.prediction(_0x2: testModel.figure(atRow: 0, column: 2).rawValue,
                                                                           _1x1: testModel.figure(atRow: 1, column: 1).rawValue,
                                                                           _2x0: testModel.figure(atRow: 2, column: 0).rawValue,
                                                                           _0x1: testModel.figure(atRow: 0, column: 1).rawValue,
                                                                           _1x0: testModel.figure(atRow: 1, column: 0).rawValue,
                                                                           _1x2: testModel.figure(atRow: 1, column: 2).rawValue,
                                                                           _2x1: testModel.figure(atRow: 2, column: 1).rawValue,
                                                                           _0x0: testModel.figure(atRow: 0, column: 0).rawValue,
                                                                           _2x2: testModel.figure(atRow: 2, column: 2).rawValue) {
                        
                        if step == nil || cost < predictions.cost {
                            cost = predictions.cost
                            step = (row: row, column: column)
                        }
                    }
                }
            }
        }
        
        return step ?? indexConverter.rowAndColumnFor(index: model.field.index(of:.none)!)
    }
}
