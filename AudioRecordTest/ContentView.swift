//
//  ContentView.swift
//  AudioRecordTest
//
//  Created by Minjoo Kim on 10/28/23.
//  Code adapted from lesson: https://www.kodeco.com/21868250-audio-with-avfoundation/lessons/1

import SwiftUI
import AVFoundation

struct ContentView: View {
  @ObservedObject var audioBox = AudioBox()
  @State var hasMicAccess = false
  @State var displayNotification = false
  
  var body: some View {
    ZStack {
      Button {
        // record audio
        if audioBox.status == .stopped {
          if hasMicAccess {
            audioBox.record(forDuration: 5)
          } else {
            requestMicrophoneAccess()
          }
        } else {
          audioBox.stopRecording()
        }
      } label: {
        Image(audioBox.status == .recording ?
              "button-record-active" :
                "button-record-inactive")
        .resizable()
        .scaledToFit()
        
      }
    }
    .onAppear{
      audioBox.setupRecorder()
    }
    .alert(isPresented: $displayNotification) {
      Alert(title: Text("Requires Microphone Access"),
            message: Text("Go to Settings to allow microphone access"),
            dismissButton: .default(Text("OK")))
    }
  }
  
  private func requestMicrophoneAccess() {
    AVAudioApplication.requestRecordPermission { granted in
      hasMicAccess = granted
      if granted {
        audioBox.record(forDuration: 5)
      } else {
        displayNotification = true
      }
    }
  }
}
