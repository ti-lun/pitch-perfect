//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Katie Bui on 3/21/16.
//  Copyright © 2016 Katie Bui. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    
    override func viewDidLoad() {
        audioEngine = AVAudioEngine()

        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        
        if let fileNSURL = receivedAudio.filePathUrl {
            audioPlayer = try? AVAudioPlayer(contentsOfURL: fileNSURL)
            audioPlayer.enableRate = true

        }
        else {
            print("omg no")
        }
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func speedChanger(speed: String) {
        if speed == "slow" {
            audioPlayer.rate = 0.5
        }
        
        else if speed == "fast" {
            audioPlayer.rate = 2
        }
        
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
    @IBAction func slowButton(sender: UIButton) {
        print("slowButton was clicked! :)")
        speedChanger("slow")
//        audioPlayer.rate = 0.5
//        audioPlayer.prepareToPlay()
//        audioPlayer.play()
    }
    
    @IBAction func fastButton(sender: UIButton) {
        print("fastButton was clicked! ^_^")
        speedChanger("fast")
//        audioPlayer.rate = 2.0
//        audioPlayer.prepareToPlay()
//        audioPlayer.play()
        
    }
    
    
    @IBAction func highButton(sender: UIButton) {
        print("highButton was clicked!  0:")
        pitchChanger("high")
    
    }
    
    @IBAction func lowButton(sender: UIButton) {
        print("lowButton was clicked!! >:)")
        pitchChanger("low")
    }
    
    func resetSounds() {
        if (audioEngine.running) {
            audioEngine.stop()
            audioEngine.reset()
            audioEngine = AVAudioEngine()
        }
    }
    
    func pitchChanger(pitch: String) {
        resetSounds()
        let pitchPlayer = AVAudioPlayerNode()
        audioEngine.attachNode(pitchPlayer)
        
        let pitchChanger = AVAudioUnitTimePitch()
        if pitch == "low" {
            pitchChanger.pitch = -1000
        }
        else if pitch == "high" {
            pitchChanger.pitch = 1000
        }

        audioEngine.attachNode(pitchChanger)
        
        audioEngine.connect(pitchPlayer, to: pitchChanger, format: nil)
        audioEngine.connect(pitchChanger, to: audioEngine.outputNode, format: nil)
        
        let audioFile = try! AVAudioFile(forReading: receivedAudio.filePathUrl)
        pitchPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        try! audioEngine.start()
        
        pitchPlayer.play()
    }
    

    
    @IBAction func stopAll(sender: UIButton) {
        print("stop!  in the name of love")
        audioPlayer.stop()
        audioEngine.stop()
    }
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
