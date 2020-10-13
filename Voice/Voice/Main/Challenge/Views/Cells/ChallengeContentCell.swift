//
//  ChallengeContentCell.swift
//  Voice
//
//  Created by Peide Xiao on 10/7/20.
//

import UIKit
import SDWebImage

class ChallengeContentCell: UITableViewCell {

    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hostNamelabel: UILabel!
    @IBOutlet weak var messageCountButton: UIButton!
    @IBOutlet weak var listenedCountButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureSubviews(challenge: ChallengeModel ) {
        dateButton.setTitle(challenge.publishedAt.convertToDateString(), for: UIControl.State.normal)
        iconImageView.sd_setImage(with: URL(string: challenge.host.avatarUrl), completed: nil)
        titleLabel.text = challenge.title
        hostNamelabel.text = "Host " + challenge.host.displayName
        listenedCountButton.setTitle("\(challenge.totalListened)", for: UIControl.State.normal)
    }
}
