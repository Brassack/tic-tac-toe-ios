//
//  TTGameController.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 3/1/17.
//  Copyright © 2017 dplatov. All rights reserved.
//

import Foundation


protocol TTGameViewProtocol: class {
    
    func showWin()
    func showLoose()
    func showDraw()
    func cleanView()
    func draw(figure: TTGameModel.Figure, atRow row: Int, atColumn column: Int)
}

class TTGameController {
    
    static let main: TTGameController = TTGameController()
    
    weak var delegate: TTGameViewProtocol?
    
    var model = TTGameModel()
    var ai: TTGameAI = TTMLPoweredGameAI()//TTCalculationGameAI()//TTGameAI()
    
    func userTapOnField(onRow row: Int, onColumn column: Int) {
        
        let fieldFigure = model.figure(atRow: row, column: column)
        
        if fieldFigure == .none {
            
            model.put(.x, intoRow: row, column: column)
            delegate?.draw(figure: .x, atRow: row, atColumn: column)
            
            switch model.state {
                case .win:
                
                    delegate?.showWin()
                case .loose:
                
                    delegate?.showLoose()
                case .draw:
                
                    delegate?.showDraw()
                case .game:
                    
                    let aiCell: (row: Int, column: Int) = ai.bestMove(for: model)
                    
                    model.put(.o, intoRow: aiCell.row, column:aiCell.column)
                    delegate?.draw(figure: .o, atRow: aiCell.row, atColumn: aiCell.column)
                    
                    switch model.state{
                        case .loose:
                            
                            delegate?.showLoose()
                        case .draw:
                            
                            delegate?.showDraw()
                        default:
                            break
                    }
            }
        }
    }
    
    func reset() {
        delegate?.cleanView()
        model.reset()
    }
}
