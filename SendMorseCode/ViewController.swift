//
//  ViewController.swift
//  SendMorseCode
//
//  Created by John James on 3/22/19.
//  Copyright © 2019 John James. All rights reserved.
//

import UIKit

class ViewController: MorsePlayerViewController {
    let cwGen = ToneOutputUnit()
    let basetime = 0.092/3.0
    
    public enum DispatchLevel {
        case main, userInteractive, userInitiated, utility, background
        var dispatchQueue: DispatchQueue {
            switch self {
            case .main:                 return DispatchQueue.main
            case .userInteractive:      return DispatchQueue.global(qos: .userInteractive)
            case .userInitiated:        return DispatchQueue.global(qos: .userInitiated)
            case .utility:              return DispatchQueue.global(qos: .utility)
            case .background:           return DispatchQueue.global(qos: .background)
            }
        }
    }
    public func delay(bySeconds seconds: Double, dispatchLevel: DispatchLevel = .main, closure: @escaping () -> Void) {
        let dispatchTime = DispatchTime.now() + seconds
        dispatchLevel.dispatchQueue.asyncAfter(deadline: dispatchTime, execute: closure)
    }
    
    override func viewDidLoad() {
        delegate = self as? MorsePlayerViewControllerDelegateProtocol
        //let dotTime = basetime
        //let dashTime = basetime * 2.0
        super.viewDidLoad()
        //tone()
        // Do any additional setup after loading the view, typically from a nib.
        let word : String = "is this"
        //MessageCleaner mc = MessageCleaner()
        let cleanedWord = MessageCleaner.clean(message: word)
        let message = MessageEncoder.encode(message: cleanedWord)!

        //tone()
        //cwGen.stop()
        let messageSignal = MorseTransmissionScheduler.scheduleTransmission(fromMessage: message)
       //playSignal(forMorseEncodedSignal: messageSignal)   //forMorseEncodedSignal morseEncodedSignal: Signal)
        let player = SignalPlayer(signals: messageSignal, delegate: self)
        player.play()

    }
    
    func tone() {
            cwGen.enableSpeaker()
            cwGen.setToneTime(t: 10)
            //played the standard tone for 1 seconds. Calling
            //
            cwGen.startToneForDuration(time: 10)
    }

    // MARK: - MorseCodePlayerDelegateProtocol Methods
    
    
    override func playSignal(forMorseEncodedSignal morseEncodedSignal: Signal) {
        
        switch morseEncodedSignal {
        case .On:
            tone()
            //audioPlayer.play()
            //signalImage.alpha = 1.0
        case .Off:
            cwGen.stop()
//            audioPlayer.pause()
//            audioPlayer.currentTime = 0.0
//            signalImage.alpha = 0.7
        }
    }
    
    override func playerFinished() {
        cwGen.stop()
//        UIView.animate(withDuration: 0.4, animations: {
//            self.signalImage.alpha = 0
//        }) { _ in
//            self.audioPlayer.stop()
//            self.delegate?.closeModal()
//        }
    }
}

