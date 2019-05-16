//
//  ViewController.swift
//  Math Trek
//
//  Created by Christopher Adeogun-Phillips on 12/04/2019.
//  Copyright © 2019 Christopher Adeogun-Phillips. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBAction func startButton(_ sender: Any) {
        
    performSegue(withIdentifier: "startGame", sender: self)
    }
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }


}

