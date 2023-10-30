//
//  AudioStatus.swift
//  AudioRecordTest
//
//  Created by Minjoo Kim on 10/29/23.
//  Code adapted from lesson: https://www.kodeco.com/21868250-audio-with-avfoundation/lessons/1

import Foundation
import AVFoundation

enum AudioStatus: Int, CustomStringConvertible {
  
  case stopped,
       playing,
       recording
  
  var audioName: String {
    let audioNames = ["Audio:Stopped", "Audio:Playing", "Audio:Recording"]
    return audioNames[rawValue]
  }
  
  var description: String {
    return audioName
  }
}
