//
//  ThirdViewController.swift
//  Math Trek
//
//  Created by Christopher Adeogun-Phillips on 26/04/2019.
//  Copyright © 2019 Christopher Adeogun-Phillips. All rights reserved.
//

import Foundation
import UIKit
import GameKit
import GoogleMobileAds
import AVFoundation


class ThirdViewController : UIViewController, GKMatchmakerViewControllerDelegate, GADBannerViewDelegate, GKGameCenterControllerDelegate{
    
    
    func gameCenterViewControllerDidFinish(_ gameCenterViewController: GKGameCenterViewController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    func matchmakerViewControllerWasCancelled(_ viewController: GKMatchmakerViewController) {
        
    }
    
    func matchmakerViewController(_ viewController: GKMatchmakerViewController, didFailWithError error: Error) {
        
        
    }
    
    
  var scoreString = ""
  var highscoreString = ""
  var recordData: String!
    
    
    //Outlets
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var highscoreLabel: UILabel!
    @IBOutlet weak var banner: GADBannerView!
    
 
    @IBAction func restartButton(_ sender: Any) {
    
        performSegue(withIdentifier: "backToStart", sender: self)
        
    }
    
    @IBAction func sharePressed(_ sender: Any) {
        
        let activityVC = UIActivityViewController(activityItems:[ "Sharpen your math skills. Download Math Trek on the App Store. It's Free! https://itunes.apple.com/app/math-trek/id1464019141?mt=8"], applicationActivities: nil)
        activityVC.popoverPresentationController?.sourceView = self.view
        
        self.present(activityVC,animated: true, completion: nil )
        
        
    }
    
    
    @IBAction func callGC(_ sender: Any) {
        
    
        let gcvc = GKGameCenterViewController()
        gcvc.gameCenterDelegate = self
        self.present(gcvc, animated: true, completion: nil)
        pushHighscore(number:Int(highscoreString)!)
        
 
        
    }
    
    func pushHighscore(number : Int){
        
        if GKLocalPlayer.local.isAuthenticated {
            
            let scoreReporter = GKScore(leaderboardIdentifier: "Leaderboard")
            scoreReporter.value = Int64(highscoreString)!
            let scoreArray : [GKScore] = [scoreReporter]
            GKScore.report(scoreArray, withCompletionHandler: nil)

            
        }
        
    }
    
    
    func authplayer(){
        
        let localPlayer = GKLocalPlayer.local
        
        localPlayer.authenticateHandler = {
            (view, error) in
            
            if view != nil {
                
                self.present(view!, animated: true, completion: nil)
                
            }else{
                
                
                print("GKLocalPlayer.local.isAuthenticated")
            }
            
            
        }
        
    }
    

    
     
   override func viewDidLoad() {
    
    
    
    banner.isHidden = true
    banner.delegate = self
    banner.adUnitID = "ca-app-pub-3603864222235662/6305496934"
    banner.adSize = kGADAdSizeSmartBannerPortrait
    banner.rootViewController = self
    banner.load(GADRequest())
    

    //Check if player is Authenticated
    if GKLocalPlayer.local.isAuthenticated == true{
        
    }else{
         authplayer()
    }
    
    //Transfer highScore Data from Second to ThirdViewcontroller (highscoreString)
    
    let userDefaults = Foundation.UserDefaults.standard
    let value = userDefaults.string(forKey: "Record")
    recordData = value
    
    scoreLabel.text = scoreString
    
    if value == nil{
        
        highscoreLabel.text = "0"
        
    }else {
        
        highscoreLabel.text = (highscoreString)

   
        }
    
 
 
 
    }
    

    
    
    /// Tells the delegate an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        banner.isHidden = false
        print("adViewDidReceiveAd")
    }
    
    /// Tells the delegate an ad request failed.
    func adView(_ bannerView: GADBannerView,
                didFailToReceiveAdWithError error: GADRequestError) {
        banner.isHidden = true
        print("adView:didFailToReceiveAdWithError: \(error.localizedDescription)")
    }
    

     
     
 

 
  
}
 


