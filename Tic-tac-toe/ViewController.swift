//
//  ViewController.swift
//  Tic-tac-toe
//
//  Created by DPlatov on 5/12/16.
//  Copyright © 2016 dplatov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let image = UIImage(named: "spriteSheet")
        
        let array = TTSpritesFactory.spritesArray(fromImage: image!, numberOfRows: 2, numberOfColumns: 4)
        
        let imageView = UIImageView(frame: self.view.frame)
        imageView.image = array.first
        self.view.addSubview(imageView)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

