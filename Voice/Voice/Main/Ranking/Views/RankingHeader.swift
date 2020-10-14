//
//  RankingHeader.swift
//  Voice
//
//  Created by Peide Xiao on 10/13/20.
//

import UIKit

class RankingHeader: UIView {

    @IBOutlet weak var hourButton: UIButton!
    @IBOutlet weak var minuteButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    
    var remainTime: Int! {
        didSet {
            hourButton.setTitle(remainTime.hour, for: .normal)
            minuteButton.setTitle(remainTime.minute, for: .normal)
            secondButton.setTitle(remainTime.second, for: .normal)
        }
    }
}
