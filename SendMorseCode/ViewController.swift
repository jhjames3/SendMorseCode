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
        let dotTime = basetime
        let dashTime = basetime * 2.0
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let word : String = "this is a test"
        //MessageCleaner mc = MessageCleaner()
        let cleanedWord = MessageCleaner.clean(message: word)
        let message = MessageEncoder.encode(message: cleanedWord)
        for aword in message!.words {
            for asymbol in aword.symbols {
                for amark in asymbol.marks {
                    switch amark {
                    case .Dit:
                        print("dit")
                        tone(time: dotTime)
                        Thread.sleep(forTimeInterval: dotTime)

                    case .Dah:
                        print("dah")
                        tone(time: dashTime)
                        Thread.sleep(forTimeInterval: dotTime)

                    }
                }
                print("letter space")
                Thread.sleep(forTimeInterval: dotTime)
            }
            print("word space")
            Thread.sleep(forTimeInterval: dashTime)
        }
        //tone()
        //cwGen.stop()
//        let mts = MorseTransmissionScheduler()
//        mts.scheduleTransmission(cleanedMessage)
    
    }
    
    func tone(time: Double) {
            cwGen.enableSpeaker()
            cwGen.setToneTime(t: time)
            //played the standard tone for 10 seconds. Calling
            //
            cwGen.startToneForDuration(time: time)
//            guard let message = "test" else {
//                showErrorLabel()
//                return
//            }
    }


}

