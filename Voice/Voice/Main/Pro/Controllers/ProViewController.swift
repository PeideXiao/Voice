//
//  RankingViewController.swift
//  Voice
//
//  Created by Peide Xiao on 9/29/20.
//

import UIKit

class ProViewController: UIViewController {
    
    @IBOutlet weak var announcementView: UIView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    
    @IBOutlet weak var planCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
}


extension ProViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return bannerArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.bannerCollectionView {
            let cell:BannerCell = collectionView.dequeueReusableCell(withReuseIdentifier: "bannercell", for: indexPath) as! BannerCell
            let banner = bannerArr[indexPath.item]
            cell.banner = banner
            return cell
        } else {
            let cell: PlanCell = collectionView.dequeueReusableCell(withReuseIdentifier: "plancell", for: indexPath) as! PlanCell
            return cell;
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.bannerCollectionView {
            return CGSize(width: SCREEN_WIDTH - 20, height: 350)
        }else {
            return CGSize(width: SCREEN_WIDTH - 20, height: 200)
        }
        
    }
}


class BannerCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var comparionTableButton: UIButton!
    
    var banner: ProBannerInfo! {
        didSet {
            titleLabel.text = banner.title
            contentLabel.text = banner.content
            comparionTableButton.isHidden = !banner.comparisonTableShow
        }
    }
}



class PlanCell: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
}
