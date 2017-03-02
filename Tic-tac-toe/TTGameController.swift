//
//  TTGameController.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 3/1/17.
//  Copyright © 2017 dplatov. All rights reserved.
//

import Foundation


protocol TTGameViewProtocol {
    func showWin()
    func showLoose()
    func showDraw()
    func cleanView()
    func draw(figure:TTGameFigure, atRow:Int, atColumn:Int)
}

class TTGameController: NSObject {
    static let sharedController:TTGameController = TTGameController()
    
    var delegate:TTGameViewProtocol?
    
    func userTapOnField(onRow row:Int, onColumn column:Int) {
        let fieldFigure = TTGameModel.sharedModel.figureAt(row, column)
        
        if(fieldFigure == TTGameFigure.none){
            
            TTGameModel.sharedModel.put(figure: TTGameFigure.o, intoRow: row, intoColumn: column)
            self.delegate?.draw(figure: TTGameFigure.o, atRow: row, atColumn: column)
            
            switch TTGameModel.sharedModel.currentState() {
                case .win:
                
                    self.delegate?.showWin()
                
                case .loose:
                
                    self.delegate?.showLoose()

                case .draw:
                
                    self.delegate?.showDraw()
                
                case .game:
                    break
            }
        }
    }
    
    
    func resetGame() {
        self.delegate?.cleanView()
        TTGameModel.sharedModel.resetModel()
    }
}
