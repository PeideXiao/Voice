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
    
    var rankList: RankList! {
        didSet {
            let yesterdayList = self.rankList.yesterday
            if let first = yesterdayList.first {
                
                rankLabel.text = String(first.rank)
                if let firstUser = first.users.first {
                    userIconImage.sd_setImage(with: URL(string: firstUser.avatar), completed: nil)
                    userNameLabel.text = firstUser.name
                    
                }
                scoreLabel.text = String(first.points)
            }
        }
    }
}
