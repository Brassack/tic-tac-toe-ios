//
//  TTGameFieldIndexConverter.swift
//  Tic-tac-toe
//
//  Created by Dmytro Platov on 11/8/18.
//  Copyright © 2018 dplatov. All rights reserved.
//

public struct TTGameFieldIndexConverter {
    
    public init(){}
    
    public func indexFor(_ row: Int, _ column: Int) -> Int{
        return 3*row + column
    }
    
    public func rowAndColumnFor(index: Int) -> (row: Int, column: Int){
        let row = index/3
        let column = index - row*3
        
        return (row, column)
    }
}
