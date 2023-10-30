//
//  AudioRecordTestApp.swift
//  AudioRecordTest
//
//  Created by Minjoo Kim on 10/28/23.
//  Code adapted from lesson: https://www.kodeco.com/21868250-audio-with-avfoundation/lessons/1

import SwiftUI
import AVFoundation

// configure audio permissions
class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    let session = AVAudioSession.sharedInstance()
    do {
      try session.setCategory(.playAndRecord, options: .defaultToSpeaker)
      try session.setActive(true)
    } catch {
      print("AVAudioSession configuration error: \(error.localizedDescription)")
    }
    
    return true
  }
}

@main
struct AudioRecordTestApp: App {
  // configure audio session
  @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

  var body: some Scene {
      WindowGroup {
          ContentView()
      }
  }
}
