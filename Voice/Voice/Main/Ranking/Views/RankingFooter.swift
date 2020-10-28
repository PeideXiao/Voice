//
//  RankingFooter.swift
//  Voice
//
//  Created by Peide Xiao on 10/13/20.
//

import UIKit

class RankingFooter: UIView {

    @IBOutlet weak var rankLabel: UILabel!
    @IBOutlet weak var userIconImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var notiLabel: UILabel!
    @IBOutlet weak var learnMoreuButton: UIButton!
    @IBOutlet weak var star: UIImageView!
    
    var rankList: RankList! {
        didSet {
            let yesterdayList = self.rankList.yesterday
            if let first = yesterdayList.first {
                
                rankLabel.text = String(first.rank)
                if let firstUser = first.users.first {
                    userIconImage.sd_setImage(with: URL(string: firstUser.avatar), completed: nil)
                    userNameLabel.text = firstUser.name
                    
                }
                notiLabel.text = "Do you want to lean freely without useing \"Tickets\"? \nCheck out our subscripition plans!"
                scoreLabel.text = String(first.points)
                learnMoreuButton.backgroundColor = UIColor.systemPurple
                learnMoreuButton.setTitleColor(UIColor.white, for: .normal);
                star.tintColor = UIColor.systemYellow
            }
        }
    }
}
