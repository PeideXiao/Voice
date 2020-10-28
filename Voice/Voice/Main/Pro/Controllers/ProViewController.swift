//
//  RankingViewController.swift
//  Voice
//
//  Created by Peide Xiao on 9/29/20.
//

import UIKit

class ProViewController: BaseViewController {
    
    @IBOutlet weak var announcementView: UIView!
    @IBOutlet weak var bannerCollectionView: UICollectionView!
    @IBOutlet weak var planCollectionView: UICollectionView!
    
    var firstView: UIView!
    var secondView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let frame = CGRect(x: 0, y: NAVI_BAR_HEIGHT + STATUS_BAR_Hight, width: SCREEN_WIDTH, height: 50)
        
        //        firstView = UIView(frame: frame)
        //        firstView.isHidden = false
        //        firstView.backgroundColor = UIColor.red
        //        view.addSubview(firstView)
        
        secondView = UIView(frame: frame)
        secondView.isHidden = true
        secondView.backgroundColor = UIColor.blue
        view.addSubview(secondView)
        
        perform(#selector(flip), with: nil, afterDelay: 1.0)
        
//        crashlyticsTest();
        
    }
    
    func crashlyticsTest() {
        let button = UIButton(type: .roundedRect)
        button.frame = CGRect(x: 50, y: 250, width: 314, height: 40)
        button.setTitle("Crash", for: [])
        button.backgroundColor = UIColor.blue
        button.addTarget(self, action: #selector(self.crashButtonTapped(_:)), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @IBAction func crashButtonTapped(_ sender: AnyObject) {
        fatalError()
    }
    
    @objc func flip() {
        
        let options: UIView.AnimationOptions = [.transitionFlipFromLeft, .curveEaseInOut, .showHideTransitionViews]
        
        UIView.transition(with: announcementView, duration: 0.5, options: options) {
            self.announcementView.isHidden = true
        } completion: { (_) in
            
        }
        
        UIView.transition(with: secondView, duration: 1, options: options) {
            self.secondView.isHidden = false
        } completion: { (_) in
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 1.0, options: UIView.AnimationOptions.transitionFlipFromTop) {
                self.secondView.frame.size.height = 200
                self.secondView.backgroundColor = UIColor.yellow
            } completion: { (_) in

            }
        }
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

//class TextRenderingView: UIView, UIKeyInput {
//    // the string we'll be drawing
//    var input = "hello"
//
//    override var canBecomeFirstResponder: Bool {
//        true
//    }
//
//    var hasText: Bool {
//        input.isEmpty == false
//    }
//
//    func insertText(_ text: String) {
//        input += text
//        setNeedsDisplay()
//    }
//
//    func deleteBackward() {
//        _ = input.popLast()
//        setNeedsDisplay()
//    }
//
//    override func draw(_ rect: CGRect) {
//        let attrs: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 32)]
//        let attributedString = NSAttributedString(string: input, attributes: attrs)
//        attributedString.draw(in: rect)
//    }
//
//    func test() {
//        let textinput = TextRenderingView(frame: CGRect(x: 20, y: 10, width: SCREEN_WIDTH - 40, height: 30))
//        textinput.backgroundColor = UIColor.white
//        textinput.becomeFirstResponder()
//
//    }
//}
