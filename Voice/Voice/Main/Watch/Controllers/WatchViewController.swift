//
//  WatchViewController.swift
//  Voice
//
//  Created by Peide Xiao on 9/28/20.
//

import UIKit

class WatchViewController: UIViewController {
    
    var navi: NaviView!
    var contentView: ContentView!
    
    var categories:[PDCategory] = [];
    
    var naviHeight:CGFloat = 40.0;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(STATUS_BAR_Hight)***\(NAVI_BAR_HEIGHT)*****\(TAB_BAR_HEIGHT)")
        
        configCollectionViews();
        loadCategories();
    }
    
    func configCollectionViews() {
        navi = NaviView(frame: CGRect(x: 0, y: STATUS_BAR_Hight + NAVI_BAR_HEIGHT, width: SCREEN_WIDTH, height: naviHeight), titles: nil);
        navi.delegate = self;
        view.addSubview(navi);
        
        contentView = ContentView(frame: CGRect(x: 0, y: STATUS_BAR_Hight + NAVI_BAR_HEIGHT + naviHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - STATUS_BAR_Hight - NAVI_BAR_HEIGHT - naviHeight), titles: nil);
        contentView.delegate = self;
        view.addSubview(contentView);
    }
    
    func loadCategories() {
        
        NetworkManager.sharedInstance.getCategories { (categories, error) in
            if let error = error {
                print("\(error)")
                return;
            }
            
            if let categories = categories {
                DispatchQueue.main.async {
                    self.categories = categories;
                    
                    let titles = self.categories.map({$0.title})
                    self.navi.titles = titles
                    self.contentView.titles = titles
                }
            }
        }
    }
}


extension WatchViewController: NaviViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt index: Int) {
        contentView.scrollContent(to: index);
    }
    
}


extension WatchViewController: ContentViewDelegate {
    func collectionView(_ collectionView: UICollectionView, scrollTo index: Int, percent:CGFloat) {
        navi.updateAnimationBar(index: index, progress: percent)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDecelerating index: Int) {
        navi.updateLayout(index: index);
    }
}


