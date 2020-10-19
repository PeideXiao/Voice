//
//  VideoPlayerViewController.swift
//  Voice
//
//  Created by Peide Xiao on 10/5/20.
//

import UIKit
import youtube_ios_player_helper

class VideoPlayerViewController: UIViewController {

    var videoDetail: VideoDetailModel! {
        didSet {
            self.videoPlayer.load(withVideoId: self.videoDetail.youtubeId, playerVars: ["playsinline": 1, "autoplay": 1, "enablejsapi": 1])
            self.captionLines = videoDetail.captionLines
            lineTableView.reloadData()
        
        }
    }
    
    var videoPlayer: YTPlayerView!
    var lineTableView: UITableView!
    var captionLines:[CaptionLine]?
    var lastCell: LineCell? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubViews();
    }
    
    func configureSubViews() {
        self.title = "Play";
        let playerHeight = NAVI_BAR_HEIGHT + STATUS_BAR_Hight + VideoPlayer_HEIGHT + 90.0;
        videoPlayer = YTPlayerView(frame: CGRect(x: 0, y: NAVI_BAR_HEIGHT + STATUS_BAR_Hight, width: SCREEN_WIDTH, height: VideoPlayer_HEIGHT))
        videoPlayer!.delegate = self;
        view.addSubview(videoPlayer!)
        
        let menuView = Bundle.main.loadNibNamed("MenuView", owner: nil, options: nil)!.last as! MenuView
        menuView.frame = CGRect(x: 0, y: NAVI_BAR_HEIGHT + STATUS_BAR_Hight + VideoPlayer_HEIGHT, width: SCREEN_WIDTH, height: 90)
        view.addSubview(menuView);
        
        lineTableView = UITableView(frame: CGRect(x: 0, y: playerHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - playerHeight))
        lineTableView.dataSource = self;
        lineTableView.delegate = self;
        lineTableView.tableHeaderView = self.headerView;
        lineTableView.estimatedRowHeight = 100;
//        lineTableView.rowHeight = UITableView.automaticDimension;
        lineTableView.register(UINib(nibName: "LineCell", bundle: Bundle.main), forCellReuseIdentifier: "lineCell")
        view.addSubview(lineTableView)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews();
        
        guard let header = lineTableView.tableHeaderView else {
            return
        }
        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: SCREEN_WIDTH, height: 0)).height
    }
    
    func heightForItem(line: String) -> CGFloat {
        var row = 1;
        let leftInset:CGFloat = 8
        let rightInset:CGFloat = 8
        let topInset: CGFloat = 8
        let margin:CGFloat = 5
        var width_total:CGFloat = leftInset + rightInset;
        let height:CGFloat = 20
        
        let lineWords = line.splitTo(with: " ")
        
        for word in lineWords {
            let wordString = String(word)
            let width = wordString.widthWithConstrainedHeight(height, UIFont.AvenirNext(weight: .Regular, 17))
            width_total += margin + width
            
            if width_total > SCREEN_WIDTH {
                width_total = leftInset + rightInset
                row += 1
            }
        }
        print("\(lineWords)*************\(row)")
        return topInset * 2 + CGFloat(row) * height + (CGFloat(row - 1)) * margin
    }
    
    lazy var headerView: UIView = {
        let header = UIView(frame: CGRect.zero)
        
        let btn = UIButton()
        btn.setTitle("click the word for definition", for: UIControl.State.normal)
        btn.setImage(UIImage.init(systemName: "lightbulb"), for: UIControl.State.normal)
        btn.titleLabel?.font = UIFont(name: "AvenirNext-Regular", size: 13);
        btn.setTitleColor(UIColor.systemGray, for: UIControl.State.normal);
        btn.sizeToFit();
        header.addSubview(btn);
        
        btn.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            btn.topAnchor.constraint(equalTo: header.topAnchor, constant: 8),
            btn.leftAnchor.constraint(equalTo: header.leftAnchor, constant: 8),
            btn.bottomAnchor.constraint(equalTo: header.bottomAnchor, constant: -5),
        ]);
        btn.sizeToFit();
        return header;
        
    }()

}

extension VideoPlayerViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.captionLines?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "lineCell") as! LineCell;
        guard let line: CaptionLine = self.captionLines?[indexPath.row] else {
            return cell;
        }
        cell.line = line
        cell.likeButton.isHidden = indexPath.row != 0
        return cell;
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let line: CaptionLine = self.captionLines?[indexPath.row] else {
            return 30;
        }
        
        let text = line.originalText.text;
        return heightForItem(line: text) + (line.editor == nil ? 0 : 35);
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let line: CaptionLine = self.captionLines?[indexPath.row] else {
            return;
        }
        if let lastCell = lastCell { lastCell.likeButton.isHidden = true; }
        let cell: LineCell = tableView.cellForRow(at: indexPath) as! LineCell
        cell.likeButton.isHidden = false;
        videoPlayer.seek(toSeconds: Float(line.startAt), allowSeekAhead: true)
        lastCell = cell;
    }
}

extension VideoPlayerViewController: YTPlayerViewDelegate {
    func playerView(_ playerView: YTPlayerView, didPlayTime playTime: Float) {
        guard let captionLines = self.captionLines else {return}
        if let index = captionLines.firstIndex(where: { $0.startAt + $0.duration > playTime }) {
            if let lastCell = lastCell { lastCell.likeButton.isHidden = true; }
            let indexPath = IndexPath(row: index, section: 0);
            lineTableView.selectRow(at: indexPath, animated: true, scrollPosition: UITableView.ScrollPosition.middle);
            if let cell = self.lineTableView.cellForRow(at: indexPath) as? LineCell {
                cell.likeButton.isHidden = false;
                lastCell = cell;
            }
        }
    }
}


