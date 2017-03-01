//
//  ViewController.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 5/12/16.
//  Copyright © 2016 dplatov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imageCells: [UIImageView]!
    let sprites = TTSpritesFactory.spritesArray(fromImage: UIImage(named: "spriteSheet")!, numberOfRows: 2, numberOfColumns: 4)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fieldTap(_ sender: UITapGestureRecognizer) {
        
        if sender.state == UIGestureRecognizerState.ended {
            let tapLocation = sender.location(in: sender.view)
            
            let row = Int(tapLocation.y)/Int((sender.view?.frame.size.width)!/3)
            let column = Int(tapLocation.x)/Int((sender.view?.frame.size.height)!/3)
            
//            print("row \(row) col \(column)")
            
            let index = 3*row + column
            let image = imageCells[index]
            
            image.image = sprites.last
            
            image.animationImages = sprites
            image.animationDuration = 1/20
            image.animationRepeatCount = 1
            image.startAnimating()
        }
    }

}

