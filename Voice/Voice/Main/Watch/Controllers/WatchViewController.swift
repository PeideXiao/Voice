//
//  WatchViewController.swift
//  Voice
//
//  Created by Peide Xiao on 9/28/20.
//

import UIKit
import MBProgressHUD


class WatchViewController: UIViewController {
    
    var navi: NaviView!
    var contentView: ContentView!
    
    var categories:[PDCategory] = [];
    var dailyPicks:[DailyPickItem] = [];
    var videos:[VideoModel] = [];
    var page:Int = 0;
    var currentCategory: PDCategory!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(STATUS_BAR_Hight)***\(NAVI_BAR_HEIGHT)*****\(TAB_BAR_HEIGHT)")
        
        configCollectionViews();
        loadCategories();
        loadDailyPick();
        
        registObserver();
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(NOTIFICATION_FOOTER_REFRESH), object: nil)
    }
    
    func configCollectionViews() {
        navi = NaviView(frame: CGRect(x: 0, y: STATUS_BAR_Hight + NAVI_BAR_HEIGHT, width: SCREEN_WIDTH, height: CATEGORY_BAR_HEIGHT), titles: nil);
        navi.delegate = self;
        view.addSubview(navi);
        
        contentView = ContentView(frame: CGRect(x: 0, y: BAR_HEIGHT_EX_TAB, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - BAR_HEIGHT));
        contentView.delegate = self;
        contentView.isHomePage = true;
        view.addSubview(contentView);
        
    }
    
    func registObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(refresh), name: NSNotification.Name(NOTIFICATION_FOOTER_REFRESH), object: nil)
    }
    
    func loadCategories() {
        Webservice.sharedInstance.getCategories(userId:USER_ID,  completion: { (categories, error) in
            if let error = error {
                print("\(error)")
                return;
            }
            
            if let categories = categories {
                DispatchQueue.main.async {
                    self.categories = categories;
                    
                    let titles = self.categories.map({$0.title})
                    self.navi.titles = titles
                    self.contentView.items = categories;
                    self.loadVideos(category: self.categories.first, offset: self.page);
                }
            }
        })
    }
    
    func loadDailyPick() {
        self.showIndicator(withTitle: nil, and: nil);
        Webservice.sharedInstance.getDailyPick { (dailyPicks, error) in
            DispatchQueue.main.async {
                self.hideIndicator();
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let dailyPicks = dailyPicks {
                    self.dailyPicks = dailyPicks;
                    self.contentView.dailyPickItems = dailyPicks;
                }
            }
        }
    }
    
    func loadVideos(category: PDCategory?, offset: Int) {
        guard let category = category else { return }
        currentCategory = category;
        self.showIndicator(withTitle: nil, and: nil);
        Webservice.sharedInstance.getVideos(query: category.query, userId: USER_ID, analyticsKey: category.analyticsKey, offset: offset) { (videos, error) in
            DispatchQueue.main.async {
                self.hideIndicator();
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let videos = videos {
                    if offset == 0 {
                        self.videos.removeAll();
                    }
                    self.videos.append(contentsOf: videos);
                    self.contentView.updateContentView(items:self.videos, cellType: .video);
                }
            }
        }
    }
    
    @objc func refresh(){
        page += page_limited;
        loadVideos(category: self.currentCategory, offset: page);
    }
    
    func proceedToVideoIntroController(video: VideoModel) {
        let videoIntroVC: VideoIntroViewController = VideoIntroViewController();
        videoIntroVC.video = video;
        self.navigationController?.pushViewController(videoIntroVC, animated: true);
    }
}


extension WatchViewController: NaviViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt index: Int) {
        contentView.scrollContent(to: index);
        let category:PDCategory = self.categories[index];
        page = 0;
        self.loadVideos(category: category, offset: page);
    }
    
}


extension WatchViewController: ContentViewDelegate {

    func collectionView(_ collectionView: UICollectionView, scrollTo index: Int, percent:CGFloat) {
        navi.updateAnimationBar(index: index, progress: percent)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDecelerating index: Int) {
        navi.updateLayout(index: index);
        let category:PDCategory = self.categories[index];
        page = 0;
        self.loadVideos(category: category, offset: page);
    }
    
    func didSelect(video: VideoModel) {
        self.proceedToVideoIntroController(video: video);
    }
    
}


