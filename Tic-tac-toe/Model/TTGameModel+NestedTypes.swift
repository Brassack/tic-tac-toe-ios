//
//  TTGameModel+NestedTypes.swift
//  Tic-tac-toe
//
//  Created by Dmytro Platov on 11/8/18.
//  Copyright © 2018 dplatov. All rights reserved.
//

extension TTGameModel {
    
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
}
