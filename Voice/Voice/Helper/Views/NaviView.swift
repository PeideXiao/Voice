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

    var titles: [String]? {
        didSet {
            naviCollectionView.reloadData()
            
            let delay = DispatchTime.now() + 0.3;
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.updateLayout(index: 0)
            }
        }
    }
    
    var naviCollectionView: UICollectionView!

    weak var delegate: NaviViewDelegate? = nil
    
    var animationBar: UIView!
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews();
    }
    
    convenience init(frame: CGRect, titles:[String]?) {
        self.init(frame: frame);
        self.titles = titles;
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
   
    func configureSubviews() {
        let naviLayout = UICollectionViewFlowLayout()
        naviLayout.scrollDirection = .horizontal;
        naviLayout.minimumInteritemSpacing = 0
        naviLayout.minimumLineSpacing = 0;
        
        naviCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: naviLayout);
        naviCollectionView.backgroundColor = UIColor.white;
        naviCollectionView.dataSource = self;
        naviCollectionView?.delegate = self;
        naviCollectionView.showsHorizontalScrollIndicator = false;
        naviCollectionView.register(UINib(nibName: "NaviCell", bundle: Bundle.main), forCellWithReuseIdentifier: "naviCell");
        
        animationBar = UIView()
        animationBar.backgroundColor = UIColor.green
        animationBar.frame = CGRect(x: 0, y: self.bounds.height - 3, width: 0, height: 3);
    
        addSubview(naviCollectionView);
        addSubview(animationBar);
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    public func updateAnimationBar(index: Int, progress: CGFloat) {
        
    }
    
    
    public func updateLayout(index: Int) {
        let indexPath:IndexPath = IndexPath(item: index, section: 0)
        self.naviCollectionView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: true)
//        self.naviCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.centeredHorizontally);
        
        if let cell: NaviCell = naviCollectionView.cellForItem(at: indexPath) as? NaviCell {
                        
            let delay:DispatchTime = DispatchTime.now() + 0.3;
            DispatchQueue.main.asyncAfter(deadline: delay) {
//                print("cell.frame = \(cell.titleLabel.text!) \(cell.frame.origin.x - self.naviCollectionView.contentOffset.x) **** \(self.naviCollectionView.contentOffset)****")
                let indicatorX:CGFloat = cell.frame.origin.x - self.naviCollectionView.contentOffset.x;
                var frame = self.animationBar.frame;
                frame.origin.x = indicatorX;
                frame.size.width = cell.bounds.size.width;
                
                UIView.animate(withDuration: 0.2) {
                    self.animationBar.frame = frame;
                    self.layoutIfNeeded();
                }
            }
            
            
        }
    }
}

extension NaviView :UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NaviCell = collectionView.dequeueReusableCell(withReuseIdentifier: "naviCell", for: indexPath) as! NaviCell;
        cell.backgroundColor = UIColor.white;
        cell.titleString = titles?[indexPath.item];
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let title = titles?[indexPath.item] else { return CGSize.zero }
        let font = UIFont.systemFont(ofSize: 15.0);
        return CGSize(width: title.widthWithConstrainedHeight(CATEGORY_BAR_HEIGHT, font) + 20, height: CATEGORY_BAR_HEIGHT)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionView.ScrollPosition.bottom)
        self.delegate?.collectionView(collectionView, didSelectItemAt: indexPath.item);
        self.updateLayout(index: indexPath.item)
    }
    
}

extension NaviView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(naviCollectionView.contentOffset)
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

