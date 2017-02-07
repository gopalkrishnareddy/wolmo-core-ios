//
//  AVPlayerItem.swift
//  Core
//
//  Created by Francisco Depascuali on 6/29/16.
//  Copyright © 2016 Wolox. All rights reserved.
//

import AVFoundation
import ReactiveCocoa
import enum Result.NoError

public extension AVPlayerItem {
    
    /**
     Moves the playback cursor to a given time.
     
     - parameter time: The time to which to seek.
     
     - returns: A SignalProducer that send true if it succedeed,
            or false if not.
     
     - seealso: seekToTime(time, completionHandler)
     */
    public func seekTo(time: CMTime) -> SignalProducer<Bool, NoError> {
        return SignalProducer { observer, _ in
            self.seekToTime(time) {
                observer.sendNext($0)
                observer.sendCompleted()
            }
        }
    }
    
}
