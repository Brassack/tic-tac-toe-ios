//
//  TTGameModel+NestedTypes.swift
//  Tic-tac-toe
//
//  Created by Dmytro Platov on 11/8/18.
//  Copyright © 2018 dplatov. All rights reserved.
//

public extension TTGameModel {
    
    enum Figure: String {
        case none = "-"
        case x = "x"
        case o = "o"
        
    }
    
    enum State {
        case game
        case win
        case loose
        case draw
    }
}
