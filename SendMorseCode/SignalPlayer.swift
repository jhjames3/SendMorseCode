//
//  SignalPlayer.swift
//  MorseCode
//
//  Created by adam smith on 7/7/16.
//  Copyright © 2016 adamontherun. All rights reserved.
//

import Foundation

/// Transmits a queue of Signals and plays them for the appropriate length of time
final class SignalPlayer: NSObject {
    var wpm = 20.0
    var signalsQueue: [Signal]
    
    /// this is a standard base playback rate. A 'dot' should play for 92 ms.
    var basePlaybackRate = 0.092  // 15wpm  0.092 //=13 wpm
    weak var delegate:MorseCodePlayerDelegateProtocol?
    
    init(signals: [Signal], delegate: MorseCodePlayerDelegateProtocol, wpm: Double) {
        self.basePlaybackRate = 1.2 / wpm
        self.delegate = delegate
        signalsQueue = signals
    }
    
    func play() {
        startTimer(forSignal: signalsQueue.first!)
    }
    
    private func startTimer(forSignal signal: Signal) {
        delegate?.playSignal(forMorseEncodedSignal: signalsQueue.first!)
        // this stops either a off or an on signal after playbackRate seconds
        let playbackRate = signal.duration(forBasePlaybackRate: basePlaybackRate)
        Timer.scheduledTimer(timeInterval: playbackRate, target: self, selector: #selector(updateDelegate), userInfo: nil, repeats: false)
    }
    
    @objc private func updateDelegate(timer: Timer) {
        
        if signalsQueue.count > 0 {
            delegate?.playSignal(forMorseEncodedSignal: signalsQueue.removeFirst())
            guard signalsQueue.first != nil else {
                delegate?.playerFinished()
                return
            }
            startTimer(forSignal: signalsQueue.first!)
        }
    }
    
}
