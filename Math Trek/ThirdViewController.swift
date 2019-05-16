//
//  ThirdViewController.swift
//  Math Trek
//
//  Created by Christopher Adeogun-Phillips on 26/04/2019.
//  Copyright © 2019 Christopher Adeogun-Phillips. All rights reserved.
//

import Foundation
import UIKit
class ThirdViewController : UIViewController {
    
  var scoreString = ""
  var highscoreString = ""
   
    
    
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
   
    
    
    @IBAction func restartButton(_ sender: Any) {
        
     self.dismiss(animated: false, completion: nil)
     self.presentingViewController?.dismiss(animated: true, completion: nil)
        
        
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        
        let activityVC = UIActivityViewController(activityItems:[ "Test your artithmatic! Download Math Trek on the App Store. It's Free!"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC,animated: true, completion: nil )
        
        
        
        
    }
    
     
   override func viewDidLoad() {
    
   
    
    
    scoreLabel.text = scoreString
    
    let userDefaults = Foundation.UserDefaults.standard
    let value = userDefaults.string(forKey: "Record")
    
    
    
    if value == nil{
        
        highscoreLabel.text = "0"
        
        
    }else {
        
        
        highscoreLabel.text = (highscoreString)

    
   
        }


    }
 

    
 }
 

