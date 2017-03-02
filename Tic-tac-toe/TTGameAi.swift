//
//  TTGameAi.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 3/1/17.
//  Copyright © 2017 dplatov. All rights reserved.
//

import UIKit

class TTGameAi: NSObject {
    func aiStep() -> (row:Int, column:Int) {
        return (0 ,0)
    }
    
    func stepHuman(_ step:Int, _ field:[TTGameFigure]) -> Bool {
        
        return true
    }
    
    func stepAi(_ step:Int, _ field:[TTGameFigure]) -> Bool {
        
        return true
    }
}
