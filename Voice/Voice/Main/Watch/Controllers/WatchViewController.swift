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
    let naviHeight: CGFloat = 40
    
    let titles: [String] = ["New", "Recomanded for you", "Ticket Free", "English Learning","New", "Recomanded for you", "Ticket Free", "English Learning","New", "Recomanded for you", "Ticket Free", "English Learning"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("\(STATUS_BAR_Hight)***\(NAVI_BAR_HEIGHT)*****\(TAB_BAR_HEIGHT)")
        
        configCollectionViews();
    }
    
    func configCollectionViews() {
        navi = NaviView(frame: CGRect(x: 0, y: STATUS_BAR_Hight + NAVI_BAR_HEIGHT, width: SCREEN_WIDTH, height: naviHeight), titles: titles);
        navi.delegate = self;
        view.addSubview(navi);
        
        contentView = ContentView(frame: CGRect(x: 0, y: STATUS_BAR_Hight + NAVI_BAR_HEIGHT + naviHeight, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - STATUS_BAR_Hight - NAVI_BAR_HEIGHT - naviHeight), titles: titles);
        contentView.delegate = self;
        view.addSubview(contentView);
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


