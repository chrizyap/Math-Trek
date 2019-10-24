//
//  SecondViewController.swift
//  Math Trek
//
//  Created by Christopher Adeogun-Phillips on 13/04/2019.
//  Copyright © 2019 Christopher Adeogun-Phillips. All rights reserved.
//
import Foundation
import UIKit
import GoogleMobileAds
import AVFoundation
import AudioToolbox
class SecondViewController: UIViewController, GADBannerViewDelegate {
    
    var soundEffect1 : AVAudioPlayer!
    var soundEffect2 : AVAudioPlayer!
    


    //Labels
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var banner: GADBannerView!
    
    //Variables
    var countdownTimer : Timer!
    var rightAnswerPlacement = 0
    var score = 0
    var recordData : String!
    var valueToInt : Int = 60
    
    
    let answers = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,
                  31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,
                  58,59,60,61,62,63,64,65,66,67,68,69,70,71,72,73,74,75,76,77,78,79,80,81,82,83,84,85,
                  86,87,88,89,90,91,92,93,94,95,96,97,98,99,100,101,102,103,104,105,106,107,108,109,110,
                  111,112,113,114,115,116,117,118,119,120,121,122,123,124,125,126,127,128,129,130,131,132,
                  133,134,135,136,137,138,139,140,141,142,143,144,145,146,147,148,149,150]
    
    
    
    //Timer Format
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        // connect value of timer to timeformarred
        return String(format:"%02d:%02d", minutes, seconds)
    }
    
    @objc func countdown (){
        if valueToInt > 0 {
            valueToInt -= 1
            
        }
        else{
            endTimer()
            
        }
        timerLabel.text = timeFormatted(valueToInt)
        
    }
    
    
    
    func startTimer() {
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector (SecondViewController.countdown), userInfo: nil, repeats: true)
        countdown()
        if countdownTimer .isValid == true{
            // warningNotification()
            
            print ("TIMER IS RUNNING")
            
        }
        
    }
    
    
    @objc func endTimer() {
        countdownTimer.invalidate()
        valueToInt = 50
        timerLabel.text = timeFormatted(valueToInt)
        if countdownTimer.isValid == false {
            print("TIMER IS NOT RUNNING")
            performSegue(withIdentifier: "gameOver", sender: self)
            
        }
    }

 
    func makeQuestion () {
        
        let factor: String!
        
        let numbers = [ 1,2,3,4,5,6,7,8,9,10,11,12]
        
        let a = numbers.randomElement()!
        let b = numbers.randomElement()!
        
        let add :Int = (a + b)
        let subtract :Int = (a - b)
        let multiply :Int = (a * b)
        
        let questions = [add,subtract,multiply]
        
        let ans = questions.randomElement()!
        
        if ans == add {
            
            factor = "+"
            
            
        } else if ans == subtract {
            
            factor = "-"
            
        } else {
            
            factor = "x"
        }
        
        print("\(a) \(String(factor)) \(b) = \(ans)")
        
        let answerString :String = String(ans)

        questionLabel.text = "\(a) \(String(factor)) \(b)"
    
        rightAnswerPlacement = Int.random(in: 1 ..< 5)
        
        //Create a Button
        var button: UIButton = UIButton()
        
        for i in 1...4
        {
            
            button = view.viewWithTag(i) as! UIButton
            
            if (i==Int(rightAnswerPlacement)){
                
                button.setTitle(answerString, for: .normal)
            }else{
                
                button.setTitle("\(answers.randomElement()!)", for: .normal)
                
            //Make sure random wrong answers never equal the correct answer
               let buttonInt =  Int(button.currentTitle!)
                
                if buttonInt == ans {
                    
                    button.setTitle("\(answers.randomElement()!)", for: .normal)
                }
                
             }
        
        }
        
    }
    
    
    //Shake to Skip Question
     override func motionBegan(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
         if event?.subtype == UIEvent.EventSubtype.motionShake{
             makeQuestion()
         }
     }
     
    
    
    @IBAction func answerPressed(_ sender: Any) {
        
        if (sender as AnyObject).tag == rightAnswerPlacement{
            
            print("correct!")
            makeQuestion()
            score += 1
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try? AVAudioSession.sharedInstance().setActive(true)
            soundEffect1.play()
        
        }else{
            
            print("wrong!")
            print("score = \(score)")
            endTimer()
            try? AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
            try? AVAudioSession.sharedInstance().setActive(true)
            soundEffect2.play()
            AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
            performSegue(withIdentifier: "gameOver", sender: self)
        }
        

        if recordData == nil {
            
            let savedString = "\(score)"
            let UserDefaults = Foundation.UserDefaults.standard
            UserDefaults.set(savedString, forKey: "Record")
            recordData = savedString
            
            
        } else {
            
            let record: Int? = Int(recordData)
            
            if score > record! {
                
                let savedString = "\(score)"
                let UserDefaults = Foundation.UserDefaults.standard
                UserDefaults.set(savedString, forKey: "Record")
                recordData = savedString
                
            }
            
        }
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // pass data to next view
        let vc = segue.destination as! ThirdViewController
        vc.scoreString =  "\(score)"
        
        if recordData != nil{
            
            vc.highscoreString = String(recordData)
            
        }
    }
    
    
    
    

 
    override func viewDidLoad() {
        
   
        
        let userDefaults = Foundation.UserDefaults.standard
        let value = userDefaults.string(forKey: "Record")
        recordData = value
        
        makeQuestion()
        startTimer()
        banner.isHidden = true
        banner.delegate = self
        banner.adUnitID = "ca-app-pub-3603864222235662/6305496934"
        banner.adSize = kGADAdSizeSmartBannerPortrait
        banner.rootViewController = self
        banner.load(GADRequest())
        
        let correctSound = Bundle.main.path(forResource: "correct", ofType: "mp3")
        let wrongSound = Bundle.main.path(forResource: "wrong", ofType: "mp3")
        
        do{
            
            soundEffect1 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath:correctSound!))
            soundEffect2 = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: wrongSound!))
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
