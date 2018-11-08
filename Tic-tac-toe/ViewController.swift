//
//  ViewController.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 5/12/16.
//  Copyright © 2016 dplatov. All rights reserved.
//

import UIKit

class ViewController: UIViewController, TTGameViewProtocol {

    @IBOutlet var imageCells: [UIImageView]!
    
    var xSprites: [UIImage] = [UIImage]()
    var oSprites: [UIImage] = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let sprites = TTSpritesFactory.spritesArray(fromImage: UIImage(named: "spriteSheet")!, numberOfRows: 2, numberOfColumns: 4)
        
        let numberOfSpritesFoFigure = sprites.count/2
        
        for index in 0..<numberOfSpritesFoFigure{
            oSprites.append(sprites[index])
        }
        
        for index in numberOfSpritesFoFigure..<sprites.count{
            xSprites.append(sprites[index])
        }
        
        TTGameController.main.delegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func fieldTap(_ sender: UITapGestureRecognizer) {

        if sender.state == UIGestureRecognizer.State.ended {
            let tapLocation = sender.location(in: sender.view)
            
            let row = Int(tapLocation.y)/Int((sender.view?.frame.size.width)!/3)
            let column = Int(tapLocation.x)/Int((sender.view?.frame.size.height)!/3)
            
            TTGameController.main.userTapOnField(onRow: row, onColumn: column)

        }
    }
    
    func showEnding(_ text:String) {
        let alert = UIAlertController(title: "Game ended", message: text, preferredStyle: .alert)
    
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { action in
            TTGameController.main.reset()
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showWin(){
        showEnding("You win!")
    }
    
    func showLoose(){
        showEnding("You loose!")
    }
    
    func showDraw(){
        showEnding("Draw!")
    }
    
    func cleanView(){
        for imageCell in imageCells{
            imageCell.image = nil
        }
    }
    
    func draw(figure: TTGameModel.TTGameFigure, atRow row: Int, atColumn column: Int){
        
        let fps = 20
        
        let imageCell = imageCells[TTGameFieldIndexConverter.indexFor(row, column)]
        
        imageCell.animationDuration = TimeInterval(xSprites.count)/TimeInterval(fps)
        imageCell.animationRepeatCount = 1
        
        switch figure {
            
        case .none:
            imageCell.image = nil
            
        case .x:
            imageCell.image = xSprites.last
            imageCell.animationImages = xSprites
            
        case .o:
            imageCell.image = oSprites.last
            imageCell.animationImages = oSprites
        }
        
        imageCell.startAnimating()
    }
}

