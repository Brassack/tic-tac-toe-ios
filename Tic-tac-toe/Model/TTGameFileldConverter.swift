//
//  TTGameFileldConverter.swift
//  Tic-tac-toe
//
//  Created by Dmytro Platov on 11/8/18.
//  Copyright © 2018 dplatov. All rights reserved.
//

struct TTGameFileldConverter {
    
    static func field(from number: Int32) -> [TTGameModel.TTGameFigure] {
        
        var field: [TTGameModel.TTGameFigure] = [TTGameModel.TTGameFigure](repeating: .none, count: 9)
        for index: Int32 in 0 ..< 9{
            
            let mask: Int32 = 0b11 << (index*2)
            
            let figureCode = (number & mask) >> (index*2)
            
            if(figureCode == 0b00){
    
                field.append(.none)
            }else if(figureCode == 0b01){
    
                field.append(.x)
            }else if(figureCode == 0b10){
    
                field.append(.o)
            }
        }
        
        return field
    }
    
    static func number(from field: [TTGameModel.TTGameFigure]) -> Int32 {
        
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
