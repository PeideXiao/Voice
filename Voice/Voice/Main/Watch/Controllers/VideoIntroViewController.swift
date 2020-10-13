//
//  VideoIntroViewController.swift
//  Voice
//
//  Created by Peide Xiao on 10/1/20.
//

import UIKit

class VideoIntroViewController: UIViewController {

    var video: VideoModel! {
        didSet {
            self.loadVideoDetail(video: video);
        }
    }
    
    var header: IntroHeaderView!
    var keyTableView: UITableView!
    var videoDetail: VideoDetailModel!
    var editors: [Editor] = [Editor]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubViews();
        self.hidesBottomBarWhenPushed = true;
    }
    
    func configureSubViews() {
        
        self.title = "Video introduction"
        if let headerView = Bundle.main.loadNibNamed("IntroHeaderView", owner: nil, options: nil)?.last as? IntroHeaderView {
            header = headerView;
            headerView.delegate = self;
        }
        
        keyTableView = UITableView(frame: self.view.frame);
        keyTableView.dataSource = self;
        keyTableView.delegate = self;
        keyTableView.estimatedRowHeight = 100;
        keyTableView.tableFooterView = UIView();
        
        keyTableView.rowHeight = UITableView.automaticDimension;
        view.addSubview(keyTableView);
        
        keyTableView.tableHeaderView = header;
        keyTableView.register(UINib(nibName: "KeyTakeAwayCell", bundle: Bundle.main), forCellReuseIdentifier: "keyTakeAwayCell")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        updateHeaderViewHight(for: keyTableView.tableHeaderView);
        
    }
    
    func updateHeaderViewHight(for header: UIView?) {
        guard let header = header else { return }
//        header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: SCREEN_WIDTH, height: 0)).height
    }
    
    
    func loadVideoDetail(video: VideoModel) {
        self.showIndicator(withTitle: nil, and: nil);
        NetworkManager.sharedInstance.getVideoDetail(videoId: video.id) { (videoDetail, error) in
            DispatchQueue.main.async {
                self.hideIndicator();
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let detail = videoDetail {
                    self.videoDetail = videoDetail;
                    self.updateHeaderView(videoDetail: detail);
                    self.handleVideoDetailResponse();
                }
            }
        }
    }
    
    func updateHeaderView(videoDetail: VideoDetailModel) {
        header.videoDetail = videoDetail;
    }
    
    func handleVideoDetailResponse() {
        guard let captionLines = self.videoDetail.captionLines else { return }
        for captionLine: CaptionLine in  captionLines {
            if captionLine.editor != nil {
                self.editors.append(captionLine.editor!);
            }
        }
        self.keyTableView.reloadData();
    }
}

extension VideoIntroViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.editors.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: KeyTakeAwayCell = tableView.dequeueReusableCell(withIdentifier: "keyTakeAwayCell") as! KeyTakeAwayCell;
        let editor: Editor = self.editors[indexPath.row]
        cell.sentenceLabel.text = "\(indexPath.row + 1). " + editor.sentence;
        guard let text = editor.items.first?.text else {
            return cell;
        }
        cell.questionLabel.text = "How to use " + text + " ?";
        return cell;
    }
}


extension VideoIntroViewController: IntroHeaderViewDelegate {
    func playVideo(with videoDetail: VideoDetailModel?) {
        guard let videoDetail = videoDetail else { return }
        let videoPlayerVC: VideoPlayerViewController = VideoPlayerViewController()
        videoPlayerVC.view.backgroundColor = UIColor.white
        videoPlayerVC.videoDetail = videoDetail
        self.navigationController?.pushViewController(videoPlayerVC, animated: true)
    }
}

class KeyTakeAwayCell: UITableViewCell {
    @IBOutlet weak var sentenceLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    
    
}
