//
//  MorseTransmissionScheduler.swift
//  MorseNew
//
//  Created by adam smith on 7/13/16.
//  Copyright © 2016 adamontherun. All rights reserved.
//

import Foundation

 ///  Adds timing information to a Morse encoded message that allows for transmission
final class MorseTransmissionScheduler {
    
    static func scheduleTransmission(fromMessage message: Message) -> [Signal] {
        
        var signals = [Signal]()
        
        for word in message.words {
            
            for symbol in word.symbols {
                
                for mark in symbol.marks {
                    
                    let signal = createOnSignal(fromMark: mark)
                    signals.append(signal)
                    signals.append(Signal.Off(InterSignalPauseDuration))
                }
                signals.removeLast()
                signals.append(Signal.Off(InterCharachterPauseDuration))
            }
            if (signals.count > 0) {
                signals.removeLast()
            }
            signals.append(Signal.Off(InterWordPauseDuration))
        }
        signals.removeLast()
        return signals
    }
    
    private static func createOnSignal(fromMark mark: Mark) -> Signal {
        
        switch mark {
        case .Dit:
            return Signal.On(DotValue)
        case .Dah:
            return Signal.On(DashValue)
        }
    }
}
