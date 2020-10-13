//
//  ChallengeHeaderCell.swift
//  Voice
//
//  Created by Peide Xiao on 10/7/20.
//

import UIKit
import SDWebImage

class ChallengeHeaderCell: UITableViewCell {
    
    @IBOutlet weak var videoImageView: UIImageView!
    @IBOutlet weak var dateButton: UIButton!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
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
        videoImageView.sd_setImage(with: URL(string: challenge.imageUrl), placeholderImage: nil, options: SDWebImageOptions.highPriority, context: nil)
        dateButton.setTitle(challenge.publishedAt.convertToDateString(), for: UIControl.State.normal)
        iconImageView.sd_setImage(with: URL(string: challenge.host.avatarUrl), completed: nil)
        titleLabel.text = challenge.title
        descLabel.text = challenge.intro
        hostNamelabel.text = "Host " + challenge.host.displayName
        listenedCountButton.setTitle("\(challenge.totalListened)", for: UIControl.State.normal)
    }
}

extension Int {
    
    func convertToDateString()->String {
        let date = self.convertToDate();
        let formatter = DateFormatter();
        formatter.dateFormat = "MM/dd";
        return formatter.string(from: date);
    }
    
    func convertToDate()-> Date {
        return Date(timeIntervalSince1970: TimeInterval(self))
    }
}
