//
//  TTSpritesFactory.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 5/12/16.
//  Copyright © 2016 dplatov. All rights reserved.
//

import UIKit

struct TTSpritesFactory {
    
    static func spritesArray(fromImage: UIImage, numberOfRows: Int16, numberOfColumns: Int16) -> [UIImage] {
        
        var array = [UIImage]()
        
        let spriteWidth: CGFloat = fromImage.size.width/CGFloat(numberOfColumns)
        let spriteHeight: CGFloat = fromImage.size.height/CGFloat(numberOfRows)
        
        let spriteSize: CGSize = CGSize(width: spriteWidth, height: spriteHeight);
        
        for row in 0..<numberOfRows {
            for column in 0..<numberOfColumns {
                let spriteRect = CGRect(origin: CGPoint(x: spriteWidth*CGFloat(column), y: spriteHeight*CGFloat(row)), size: spriteSize)
                let sprite = UIImage(cgImage: fromImage.cgImage!.cropping(to: spriteRect)!)
                
                array.append(sprite)
            }
        }

        return array;
    }
}
