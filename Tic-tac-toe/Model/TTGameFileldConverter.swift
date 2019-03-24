//
//  TTGameFileldConverter.swift
//  Tic-tac-toe
//
//  Created by Dmytro Platov on 11/8/18.
//  Copyright © 2018 dplatov. All rights reserved.
//

public struct TTGameFileldConverter {
    
    var indexConverter = TTGameFieldIndexConverter()
    public init(){}
    
    public func model(from number: Int32) -> TTGameModel {
        var model = TTGameModel()
        
        for offset: Int32 in 0 ..< 9 {
            
            let mask: Int32 = 0b11 << (offset*2)
            
            let figureCode = (number & mask) >> (offset*2)
            
            let index = Int(offset)
            if(figureCode == 0b00){
                
                let position = indexConverter.rowAndColumnFor(index: index)
                model.put(.none, intoRow: position.row, column: position.column)
            }else if(figureCode == 0b01){
                
                let position = indexConverter.rowAndColumnFor(index: index)
                model.put(.x, intoRow: position.row, column: position.column)
            }else if(figureCode == 0b10){
                
                let position = indexConverter.rowAndColumnFor(index: index)
                model.put(.o, intoRow: position.row, column: position.column)
            }
        }
        
        return model
    }
    
    public func number(from model: TTGameModel) -> Int32 {
        
        let field = model.field
        var number: Int32 = 0b0
        
        for index in 0..<field.count{
            
            let figure = field[index]
            var figureNumber: Int32
            switch figure {
            case .none:
                
                figureNumber = 0b00
            case .x:
                
                figureNumber = 0b01
            case .o:
                
                figureNumber = 0b10
            }
            
            figureNumber = figureNumber << Int32(2*index)
            
            number = number | figureNumber
        }
        
        return number
    }
}
