//
//  ViewController.swift
//  Math Trek
//
//  Created by Christopher Adeogun-Phillips on 12/04/2019.
//  Copyright © 2019 Christopher Adeogun-Phillips. All rights reserved.
//

import UIKit
import GoogleMobileAds
import AVFoundation
import GameKit
import UserNotifications
import PusherSwift



class ViewController: UIViewController, GADBannerViewDelegate{
    
 
    var soundEffectClick : AVAudioPlayer!
    
    
    //Outlet
    @IBOutlet weak var banner: GADBannerView!
    
    @IBAction func startButton(_ sender: Any) {
        
        
        try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
        try? AVAudioSession.sharedInstance().setActive(true)
        soundEffectClick.play()
        
    performSegue(withIdentifier: "startGame", sender: self)
    }
    

 
    override func viewDidLoad() {
    
        super.viewDidLoad()
        
        
        /*
        
        let content = UNMutableNotificationContent()
        content.title = "Hey if you will not come back"
        content.subtitle = "your timer will be killed"
        content.body = "Help a friend out why dont you"
        content.categoryIdentifier = "pizza.reminder.category"
    
        //getting the notification trigger
        //it will be called after 5 seconds
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        
        let request  = UNNotificationRequest(identifier: "testID", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
 
 
 */
        
        banner.isHidden = true
        banner.delegate = self
        banner.adUnitID = "ca-app-pub-3603864222235662/6305496934"
        banner.adSize = kGADAdSizeSmartBannerPortrait
        banner.rootViewController = self
        banner.load(GADRequest())
        
        
        let clickSound = Bundle.main.path(forResource: "click", ofType: "mp3")
        
        
        do{
            
            soundEffectClick = try AVAudioPlayer(contentsOf: URL(fileURLWithPath:clickSound!))
        }
        catch{
            print(error)
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

