//
//  RankingViewController.swift
//  Voice
//
//  Created by Peide Xiao on 9/29/20.
//

import UIKit

class ReviewViewController: UIViewController {

    let categories:[String] = ["Recently watched", "Saved Videos","Saved Words", "Saved Sentences"]
    var navi: NaviView!
    var contentView: ContentView!
    var recentlyWatched:[VideoModel] = []
    var savedVideos:[VideoModel] = []
    var savedWords:[DictionaryWord] = []
    var savedCaptionLines: [CaptionLine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionViews()
        loadRecentlyWatched()
    }
    
    func configCollectionViews() {
        navi = NaviView(frame: CGRect(x: 0, y: STATUS_BAR_Hight + NAVI_BAR_HEIGHT, width: SCREEN_WIDTH, height: CATEGORY_BAR_HEIGHT), titles: nil);
        navi.delegate = self;
        navi.titles = self.categories
        view.addSubview(navi);
        
        contentView = ContentView(frame: CGRect(x: 0, y: BAR_HEIGHT_EX_TAB, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - BAR_HEIGHT));
        contentView.delegate = self;
        view.addSubview(contentView);
        contentView.items = self.categories;
        self.view.backgroundColor = UIColor.systemGray6
    }
    
    func loadRecentlyWatched() {
        self.showIndicator(withTitle: nil, and: nil);
        NetworkManager.sharedInstance.getWatchedVideos(offset: 0) { (watchedVideos, error) in
            DispatchQueue.main.async {
                self.hideIndicator();
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let videos = watchedVideos{
                    self.recentlyWatched = videos
                    self.contentView.updateContentView(items: videos, cellType: .video)
                }
            }
        }
    }
    
    func loadSavedVideos() {
        self.showIndicator(withTitle: nil, and: nil);
        NetworkManager.sharedInstance.getSavedVideos(offset: 0) { (savedVideos, error) in
            DispatchQueue.main.async {
                self.hideIndicator();
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let videos = savedVideos{
                    self.savedVideos = videos
                    self.contentView.updateContentView(items: videos, cellType: .video)
                }
            }
        }
    }
    
    func loadSavedWords() {
        self.showIndicator(withTitle: nil, and: nil);
        NetworkManager.sharedInstance.getSavedWords(offset: 0, direction: "desc", key: "collectedAt") { (savedWords, error) in
            DispatchQueue.main.async {
                self.hideIndicator();
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let words = savedWords{
                    self.savedWords = words
                    self.contentView.updateContentView(items: words, cellType: .word)
                }
            }
        }
    }
    
    func loadCaptionLines() {
        self.showIndicator(withTitle: nil, and: nil);
        NetworkManager.sharedInstance.getSavedCaptionLines(offset: 0, direction: "desc", key: "collectedAt") { (savedLines, error) in
            DispatchQueue.main.async {
                self.hideIndicator();
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let lines = savedLines{
                    self.savedCaptionLines = lines
                    self.contentView.updateContentView(items: lines, cellType: .captionLine)
                }
            }
        }
        
        
    }
}



extension ReviewViewController: NaviViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt index: Int) {
        contentView.scrollContent(to: index);
//        let category:PDCategory = self.categories[index];
//        page = 0;
//        self.loadVideos(category: category, offset: page);
    }
    
}


extension ReviewViewController: ContentViewDelegate {

    func collectionView(_ collectionView: UICollectionView, scrollTo index: Int, percent:CGFloat) {
        navi.updateAnimationBar(index: index, progress: percent)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDecelerating index: Int) {
        navi.updateLayout(index: index);
        switch index {
        case 0:
            self.loadRecentlyWatched()
        case 1:
            self.loadSavedVideos()
        case 2:
            self.loadSavedWords()
        default:
            self.loadCaptionLines()
        }
    }
    
    func didSelect(video: VideoModel) {
//        self.proceedToVideoIntroController(video: video);
    }
    
}
