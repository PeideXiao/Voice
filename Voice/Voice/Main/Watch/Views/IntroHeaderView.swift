//
//  IntroHeaderView.swift
//  Voice
//
//  Created by Peide Xiao on 9/30/20.
//

import Foundation
import UIKit
import SDWebImage

protocol IntroHeaderViewDelegate: NSObjectProtocol {
    func playVideo(with videoDetail: VideoDetailModel?)
}

class IntroHeaderView: UIView {
    @IBOutlet weak var proCategoryTitleLabel: UILabel!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var likedCountButton: UIButton!
    @IBOutlet weak var playedCountButton: UIButton!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var pointDetailIndicator: UIButton!
    @IBOutlet weak var tableViewTitleLabel: UILabel!
    
    weak var delegate: IntroHeaderViewDelegate? = nil
    
    var videoDetail: VideoDetailModel! {
        didSet {
            proCategoryTitleLabel.text = videoDetail.proCategories?.first?.title
            videoTitleLabel.text = videoDetail.title
            coverImageView.sd_setImage(with: URL(string: videoDetail.imageUrl), completed: nil)
            tableViewTitleLabel.text = "Key takeaways"
            
            levelLabel.text = " \(videoDetail.CEFRLevelTag) ";
            
            var color:UIColor = .white;
            switch videoDetail.CEFRLevel {
            case "B1":
                color = UIColor.systemYellow;
            case "A2":
                color = UIColor.systemGreen;
            default:
                color = UIColor.systemRed;
            }
            levelLabel.backgroundColor = color;
            self.setupMenuView()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib();
        addSubview(self.playBtn)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        self.playBtn.center = self.coverImageView.center
    }

    
    func setupMenuView() {
        
        guard let points:[PointModel] = videoDetail.points else { return };
        let merge: CGFloat = 10.0
        let count: CGFloat = CGFloat(points.count);
        let width: CGFloat = (SCREEN_WIDTH - 8 * 2 - merge * (count + 1.0)) / count;
        
        for (index, value) in points.enumerated() {
            let x = merge * (CGFloat(index + 1)) + width * CGFloat(index)
            let item: MenuItem = MenuItem(frame: CGRect(x: x, y: 0, width: width, height: width), imageName: value.stage, count: value.points, title: value.stage);
            self.menuView.addSubview(item);
        }
    }
    
    @objc func proceedToVideoPlayerViewController() {
        self.delegate?.playVideo(with: self.videoDetail)
    }
    
    lazy var playBtn: UIButton = {
       let btn = UIButton()
        btn.setImage(UIImage(named: "play-black"), for: .normal);
        btn.addTarget(self, action: #selector(proceedToVideoPlayerViewController), for: UIControl.Event.touchUpInside)
        btn.sizeToFit()
        return btn;
    }()
}


