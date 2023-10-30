//
//  AudioBox.swift
//  AudioRecordTest
//
//  Created by Minjoo Kim on 10/28/23.
//  Code adapted from lesson: https://www.kodeco.com/21868250-audio-with-avfoundation/lessons/1

import Foundation
import AVFoundation

class AudioBox: NSObject, ObservableObject {
  
  @Published var status: AudioStatus = .stopped
  
  var audioRecorder: AVAudioRecorder?
  var audioPlayer: AVAudioPlayer?
  
  // save one audio to temporary directory (only one at a time)
  var urlForMemo: URL {
    let fileManager = FileManager.default
    let tempDir = fileManager.temporaryDirectory
    let filePath = "TempMemo.caf"
    return tempDir.appendingPathComponent(filePath)
  }
  
  // recording function
  func setupRecorder() {
    // set up recording setting
    let recordSettings: [String: Any] = [
      AVFormatIDKey: Int(kAudioFormatLinearPCM),
      AVSampleRateKey: 44100.0,
      AVNumberOfChannelsKey: 1,
      AVEncoderAudioQualityKey: AVAudioQuality.medium.rawValue
    ]
    
    //creating recorder
    do {
      audioRecorder = try AVAudioRecorder(url: urlForMemo, settings: recordSettings)
      audioRecorder?.delegate = self
    } catch {
      print("Error creating audioRecording")
    }
  }
  
  func record(forDuration duration: TimeInterval) {
    audioRecorder?.record(forDuration: duration)
    status = .recording
  }
  
  func stopRecording() {
    audioRecorder?.stop()
    status = .stopped
  }
}

extension AudioBox: AVAudioRecorderDelegate {
  func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
    status = .stopped
  }
}
