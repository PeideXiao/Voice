//
//  NaviView.swift
//  collectionViewTest
//
//  Created by Peide Xiao on 9/25/20.
//

import UIKit


protocol NaviViewDelegate: NSObjectProtocol {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt index: Int);
}

class NaviView: UIView {

    var titles: [String]! {
        didSet {
            naviCollectionView.reloadData()
        }
    }
    
    var naviCollectionView: UICollectionView!
    let naviHeight:CGFloat = 40
    let naviBarHeight:CGFloat = 84
    weak var delegate: NaviViewDelegate? = nil
    
    var animationBar: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews();
    }
    
    convenience init(frame: CGRect, titles:[String]) {
        self.init(frame: frame);
        self.titles = titles;
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func configureSubviews() {
        let naviLayout = UICollectionViewFlowLayout()
        naviLayout.scrollDirection = .horizontal;
        naviLayout.minimumInteritemSpacing = 10
        naviLayout.minimumLineSpacing = 10;
        
        naviCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: naviLayout);
        naviCollectionView.backgroundColor = UIColor.white;
        naviCollectionView.dataSource = self;
        naviCollectionView?.delegate = self;
        naviCollectionView.register(UINib(nibName: "NaviCell", bundle: Bundle.main), forCellWithReuseIdentifier: "naviCell");
        
        animationBar = UIView()
        animationBar.frame = CGRect(x: 0, y: self.bounds.height - 2, width: 100, height: 2);
        animationBar.backgroundColor = UIColor.green
        
        addSubview(naviCollectionView);
        addSubview(animationBar);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    public func updateAnimationBar(index: Int, progress: CGFloat) {
        
    }
    
    
    public func updateLayout(index: Int) {
        self.naviCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
        
        let cell:NaviCell = self.naviCollectionView.cellForItem(at: IndexPath(item: index, section: 0)) as! NaviCell;
        var x = self.animationBar.frame
        x.size.width = cell.bounds.width
        x.origin.x = cell.frame.origin.x - naviCollectionView.contentOffset.x
        
        print("x:\(x)")
        UIView.animate(withDuration: 0.5) {
            self.animationBar.frame = x;
            self.setNeedsLayout()
        }

    }
}

extension NaviView :UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NaviCell = collectionView.dequeueReusableCell(withReuseIdentifier: "naviCell", for: indexPath) as! NaviCell;
        cell.backgroundColor = UIColor.white;
        cell.titleString = titles[indexPath.item];
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let title = titles[indexPath.item];
        let font = UIFont.systemFont(ofSize: 15.0);
        return CGSize(width: title.widthWithConstrainedHeight(naviHeight, font) + 30, height: naviHeight - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.bottom)
        self.delegate?.collectionView(collectionView, didSelectItemAt: indexPath.item);
    }
    
}


class NaviCell: UICollectionViewCell {

    
    var titleString: String? {
        didSet {
            titleLabel.text = titleString;
        }
    }
    
    
    @IBOutlet weak var titleLabel: UILabel!
    var width: CGFloat = 0;
    
    
    override class func awakeFromNib() {
        super.awakeFromNib();
        
        
    }
    
}


extension String {
    func widthWithConstrainedHeight(_ height: CGFloat, _ font: UIFont) -> CGFloat {
        let constraintRect: CGSize = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height);
        let boundingBox:CGRect = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return boundingBox.width
    }
    
}

