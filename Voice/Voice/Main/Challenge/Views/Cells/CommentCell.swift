//
//  CommentCell.swift
//  Voice
//
//  Created by Peide Xiao on 10/8/20.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var commentTextLabel: UILabel!
    @IBOutlet weak var audioPlayButton: UIButton!
    @IBOutlet weak var createdTimeLabel: UILabel!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var commentCountButton: UIButton!
    @IBOutlet weak var showMoreButton: UIButton!
    
    var comment: Comment!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showMore(_ sender: UIButton) {
    }
    
    
    @IBAction func share(_ sender: UIButton) {
    }
    
    @IBAction func play(_ sender: UIButton) {
        guard let urlStr = comment.audioUrl else { return }
        AudioPlayer.sharedInstance.play(with: URL(string: urlStr));
    }
    
    public func configureSubviews(comment: Comment? ) {
        guard let comment = comment else {
            return;
        }
        self.comment = comment
        iconImageView.sd_setImage(with: URL(string: comment.owner.avatarUrl), completed: nil)
        authorNameLabel.text = comment.owner.displayName
        commentTextLabel.text = comment.content
        let timeStr = comment.createdAt.convertToDateString()
        if timeStr == Date().toString() {
            createdTimeLabel.text = "Today"
        } else {
            createdTimeLabel.text = timeStr
        }
        audioPlayButton.isHidden = comment.audioUrl == nil
        showMoreButton.isHidden = comment.mode == FetchMode.Others
        shareButton.isHidden = comment.mode == FetchMode.Others
    }
    
}
