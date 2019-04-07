//
//  ViewController.swift
//  SendMorseCode
//
//  Created by John James on 3/22/19.
//  Copyright © 2019 John James. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: MorsePlayerViewController {
    
    @IBOutlet weak var wpm: UITextField!
    
    @IBOutlet weak var numWords: UITextField!
    var contents = ""
    let cwGen = ToneOutputUnit()
    var myStrings = [String]()
    var numWordsVal = 0
    var word = ""
    var wordIndex = 0
    let syn = AVSpeechSynthesizer()
    var wordsAlreadyHeard = Set<Int>()
    var wordsNotYetHeard = Set<Int>()


    @IBAction func newWord(_ sender: Any) {
        setWord()
    }
    
    
    @IBAction func addNewWord(_ sender: Any) {
        moveRandomWord()
    }
    
    @IBAction func play(_ sender: Any) {
        sendWord(word: word)
        print(word)
    }
    
    @IBAction func say(_ sender: Any) {
        let utterance = AVSpeechUtterance(string: word)
        //            English (Australia) - en-AU
        //            English (Ireland) - en-IE
        //            English (South Africa) - en-ZA
        //            English (United Kingdom) - en-GB
        //            English (United States) - en-US
        utterance.voice = AVSpeechSynthesisVoice(language:  "en-US")        //"fr-CA")       //"en-US")      //"en-GB")
        utterance.rate = 0.4
        syn.speak(utterance)
        //self.sendWord(word: word)
        print(word)

    }
    
    private func moveRandomWord() {
        let numberOfWordsLeftToLearn = wordsNotYetHeard.count
        //        wordIndex = Int(arc4random_uniform(UInt32(currentNumNewWords)))
        if (numberOfWordsLeftToLearn > 0) {
            wordIndex = wordsNotYetHeard.randomElement()!
            wordsNotYetHeard.remove(wordIndex)
            wordsAlreadyHeard.insert(wordIndex)
            numWordsVal = wordsAlreadyHeard.count
            numWords.text = String(numWordsVal)
        }
    }
    
    private func setWord() {
        wordIndex = wordsAlreadyHeard.randomElement()!
        print("wordIndex "+String(wordIndex))
        word = myStrings[wordIndex-1]
        print(word)
    }
    
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
        super.viewDidLoad()
//       let file = AppFile()
//        _ = file.writeFile(containing: "this is a test file", to: .Documents, withName: "common1.txt")
//        _ = file.list()
//        print("file written...")
        
        // Do any additional setup after loading the view, typically from a nib.
        if let filepath = Bundle.main.path(forResource: "test", ofType: "txt") {
            do {
                contents = try String(contentsOfFile: filepath)
                print(contents)
                //let contents = file.readFile(at: .Documents, withName: "common1.txt")
                myStrings = contents.components(separatedBy: .newlines)
                numWordsVal = myStrings.count;
                wordsNotYetHeard = Set<Int>(1...numWordsVal)
                moveRandomWord()
                moveRandomWord()
                moveRandomWord()
                moveRandomWord()
                moveRandomWord()
                setWord()
                
            } catch {
                // contents could not be loaded
            }
        } else {
            // example.txt not found!
        }

        

    }
    
    func sendWord(word: String) {
        //MessageCleaner mc = MessageCleaner()
        let cleanedWord = MessageCleaner.clean(message: word)
        let message = MessageEncoder.encode(message: cleanedWord)!
        
        let messageSignal = MorseTransmissionScheduler.scheduleTransmission(fromMessage: message)
        //playSignal(forMorseEncodedSignal: messageSignal)   //forMorseEncodedSignal morseEncodedSignal: Signal)
        let currentwpm = Double(wpm.text!)!
        let player = SignalPlayer(signals: messageSignal, delegate: self, _wpm: currentwpm)
        player.play()
    }
    
    func readFile(fileName: String, fileType: String) -> String {
        let file = fileName + fileType//this is the file. we will write to and read from it
        var text2 = "" //just a text
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            //reading
            do {
                text2 = try String(contentsOf: fileURL, encoding: .utf8)
            }
            catch {/* error handling here */}
        }
        return text2
    }
    
    func tone() {
            cwGen.enableSpeaker()
            cwGen.setToneTime(t: 10)
            cwGen.startToneForDuration(time: 10)
    }

    // MARK: - MorseCodePlayerDelegateProtocol Methods
    
    
    override func playSignal(forMorseEncodedSignal morseEncodedSignal: Signal) {
        
        switch morseEncodedSignal {
        case .On:
            tone()
        case .Off:
            cwGen.stop()
        }
    }
    
    override func playerFinished() {
        cwGen.stop()
    }
}

