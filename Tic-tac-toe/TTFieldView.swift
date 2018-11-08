//
//  TTFieldView.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 3/1/17.
//  Copyright © 2017 dplatov. All rights reserved.
//

import UIKit

@IBDesignable
class TTFieldView: UIView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let offset = rect.size.width/15
        let lineWidth: CGFloat = 0.3
        let lineColour = UIColor(white: 0.5, alpha: 1)
        
        let sectionWidht = rect.size.width/3
        let sectionHeight = rect.size.height/3
        
        lineColour.set()
        
        //top horisontal
        var path = UIBezierPath()
        var firstPoint = CGPoint(x: offset, y: sectionHeight)
        var secondPoint = CGPoint(x: rect.size.width - offset, y: sectionHeight)

        func stroke(){
            path.lineWidth = lineWidth
            path.move(to: firstPoint)
            path.addLine(to: secondPoint)
            path.close()
            path.stroke()
        }
        
        stroke()
        
        //bottom horisontal
        path = UIBezierPath()
        firstPoint = CGPoint(x: offset, y: 2*sectionHeight)
        secondPoint = CGPoint(x: rect.size.width - offset, y: 2*sectionHeight)

        stroke()
        
        //left vertical
        path = UIBezierPath()
        firstPoint = CGPoint(x: sectionWidht, y: offset)
        secondPoint = CGPoint(x: sectionWidht, y: rect.size.height - offset)
        
        stroke()
        
        //right vertical
        path = UIBezierPath()
        firstPoint = CGPoint(x: 2*sectionWidht, y: offset)
        secondPoint = CGPoint(x: 2*sectionWidht, y: rect.size.height - offset)
        stroke()
    }
}
