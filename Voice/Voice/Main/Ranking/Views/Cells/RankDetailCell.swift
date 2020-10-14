//
//  RankDetailCell.swift
//  Voice
//
//  Created by Peide Xiao on 10/13/20.
//

import UIKit

class RankDetailCell: UITableViewCell {
    
    @IBOutlet weak var rankMainView: UIView!
    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var userIconImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    @IBOutlet weak var sameRankUsersView: UIView!
    @IBOutlet weak var othersIconsView: UIView!
    @IBOutlet weak var andOthersTitleLabel: UILabel!
    
    
    @IBOutlet weak var ellipsisView: UIView!
    @IBOutlet weak var ellipsisImageView: UIImageView!
    
    
    var rankItem: RankItem! {
        didSet {
            ellipsisView.isHidden = !rankItem.showEllipsis!
            rankLabel.text = String(rankItem.rank)
            if let firstUser = rankItem.users.first {
                userIconImage.sd_setImage(with: URL(string: firstUser.avatar), completed: nil)
                userNameLabel.text = firstUser.name
                
            }
            scoreLabel.text = String(rankItem.points)
            sameRankUsersView.isHidden = rankItem.users.count == 1
            if (rankItem.isSelf) {
                rankMainView.layer.borderColor = UIColor.purple.cgColor
                rankMainView.layer.borderWidth = 1
            }
            self.configureOtherUsersWithSameRankView(users: rankItem.users)
        }
    }
    
    var otherUsersCount:Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.ellipsisImageView.transform = CGAffineTransform(rotationAngle: CGFloat(Double.pi/2))
    }

    func configureOtherUsersWithSameRankView(users: [RankUser]) {
        otherUsersCount = users.count
        andOthersTitleLabel.text = "and \(otherUsersCount) others"
        for (index,user) in users.enumerated() {
            let width:CGFloat = 12.0
            let height = width
            let x: CGFloat = 8.0 * CGFloat(index)
            let icon: UIImageView = UIImageView(frame: CGRect(x: x, y: 0, width: width, height: height))
            icon.sd_setImage(with: URL(string: user.avatar), completed: nil)
            icon.layer.cornerRadius = 6
            icon.layer.masksToBounds = true
            othersIconsView.addSubview(icon)
        }
    }
    
}
