//
//  AudioPlayer.swift
//  Voice
//
//  Created by Peide Xiao on 10/9/20.
//

import UIKit
import AVFoundation

// record & play
class AudioPlayer: NSObject {
    
    static let sharedInstance = AudioPlayer()
    var audioSession: AVAudioSession!
    var audioRecorder: AVAudioRecorder!
    var audioPlayer: AVAudioPlayer!
    var filePath: URL?
    
    override init() {
        super.init()
        
        audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playAndRecord, mode: .default)
        try? audioSession.setActive(true)
        try? audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
    }
    
    public func prepareRecording(completion:(()->())?) {
        
        
        if completion != nil {
            audioSession.requestRecordPermission {(allowed) in
                DispatchQueue.main.async {
                    if allowed {
                        print("You can start to record.")
                        completion!();
                    }
                }
            }
        }
//        audioSession = AVAudioSession.sharedInstance()
//
//        do {
//            try audioSession.setCategory(.playAndRecord, mode: .default)
//            try audioSession.setActive(true)
//            try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
//            if completion != nil {
//                audioSession.requestRecordPermission {(allowed) in
//                    DispatchQueue.main.async {
//                        if allowed {
//                            print("You can start to record.")
//                            completion!();
//                        }
//                    }
//                }}
//        } catch {
//            print("session setup error: \(error)")
//        }
    }
    
    public func startRecording(_ filePathComponent: String) {
        if audioPlayer != nil {
            audioPlayer.stop();
        }
        
        let audioFileName = FileManager.default.documentsDirectory().appendingPathComponent(filePathComponent)
        filePath = audioFileName
        print(audioFileName.absoluteURL)
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFileName, settings: settings)
            audioRecorder.delegate = self
            audioRecorder.record()
            
        } catch {
            finishRecording()
        }
    }
    
    public func stopRecording() {
        self.finishRecording()
    }
    
    public func play(with filePath: URL?) {
        
        guard let filePath = filePath else {
            print("The audio doesn't exsit");
            return
        }
        
        print("FilePath****:  \r\n\(filePath)\r\n")
        if audioPlayer != nil {
            audioPlayer.stop();
        }
        
        do {
            let data = try Data(contentsOf: filePath)
            let lastPathComponent = filePath.lastPathComponent
            let filePath = FileManager.default.documentsDirectory().appendingPathComponent(lastPathComponent)
            try data.write(to: filePath)
    
            audioPlayer = try AVAudioPlayer(contentsOf: filePath)
            audioPlayer.volume = 1.0
            
            audioPlayer.play()
        } catch {
            print("audio play error: \(error)")
        }
        
    }
    
    public func stop() {
        audioPlayer.stop()
        audioPlayer = nil
    }
    
    fileprivate func finishRecording() {
        audioRecorder.stop()
        audioRecorder = nil
    }
    
}

extension AudioPlayer: AVAudioRecorderDelegate {
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
            print("audioRecorderDidFinishRecording")
        }
    }
    
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        if let error = error {
            print(error)
        }
    }
}
