//
//  RecordPanel.swift
//  Voice
//
//  Created by Peide Xiao on 10/8/20.
//

import UIKit

class RecordPanel: UIView {
    
    @IBOutlet weak var recordingStackView: UIStackView!
    @IBOutlet weak var timerStackView: UIStackView!
    @IBOutlet weak var flashView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    
    @IBOutlet weak var playerStackView: UIStackView!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var closeButton: UIButton!
    
    var audioPlayer: AudioPlayer = AudioPlayer.sharedInstance
    
    var timer: Timer?
    var isShow: Bool = true;
    var second: Int = 0;
    var audioData:Data?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    @IBAction func recordButton(_ sender: UIButton) {
        if !sender.isSelected  {
            
            let component = UUID().uuidString + "_\(UserConfig.sharedInstance.userId)" + ".m4a"
            audioPlayer.prepareRecording() {
                sender.isSelected = true
                self.timerStackView.isHidden = false
                self.setupTimer()
                self.audioPlayer.startRecording(component)
            }
        }
        else {
            audioPlayer.stopRecording()
            timer?.invalidate();
            timer = nil
            self.recordingStackView.isHidden = true
            self.playerStackView.isHidden = false
            self.playButton.setTitle(self.second.convertToTimer(), for: UIControl.State.normal)
            
            do {
                audioData = try Data(contentsOf: audioPlayer.filePath!)
                
            } catch {
                
            }
        }
    }
    
    @IBAction func play(_ sender: UIButton) {
        audioPlayer.play(with: audioPlayer.filePath)
    }
    
    @IBAction func switchToRecording(_ sender: UIButton) {
        audioPlayer.stop()
        self.recordingStackView.isHidden = false
        self.playerStackView.isHidden = true
        self.second = 0
        self.recordButton.isSelected = false
        self.timerStackView.isHidden = true
        self.timeLabel.text = "00:00"
        
    }
    
    private func setupTimer() {
        if timer == nil {
            timer = Timer(timeInterval: 1.0, repeats: true, block: { (timer) in
                self.second += 1;
                self.flashView.isHidden = self.isShow;
                self.isShow = !self.isShow;
                self.timeLabel.text = self.second.convertToTimer();
            })
            
            RunLoop.current.add(timer!, forMode: RunLoop.Mode.default)
        }
    }
}


