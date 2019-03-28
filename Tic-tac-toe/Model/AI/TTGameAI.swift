//
//  TTGameAI.swift
//  Tic-tac-toe
//
//  Created by Dmytro Platov on 3/27/19.
//  Copyright © 2019 dplatov. All rights reserved.
//

import UIKit

protocol TTGameAI: class {
    func bestMove(for model: TTGameModel) -> (row: Int, column: Int)
}
