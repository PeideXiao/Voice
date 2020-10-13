//
//  ChallengeDetailHeader.swift
//  Voice
//
//  Created by Peide Xiao on 10/8/20.
//

import UIKit
import youtube_ios_player_helper

class ChallengeDetailHeader: UIView {

    @IBOutlet weak var playerView: YTPlayerView!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var authorIconView: UIImageView!
    
    @IBOutlet weak var listenedCountButton: UIButton!
    @IBOutlet weak var messageCountButton: UIButton!
    @IBOutlet weak var likeCountButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var audioSlider: UISlider!
    @IBOutlet weak var timerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        audioSlider.setThumbImage(UIImage(named: "dial"), for: UIControl.State.normal)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
    }
    
    public func configureSubviews(detail: ChallengeDetailModel) {
        playerView.load(withVideoId: detail.youtubeId, playerVars: ["playsinline": 1, "autoplay": 1])
        contentLabel.text = detail.content
        authorNameLabel.text = detail.host.displayName
        authorIconView.sd_setImage(with: URL(string: detail.host.avatarUrl), completed: nil)
        listenedCountButton.setTitle("\(detail.totalListened)", for: UIControl.State.normal)
    }
}
