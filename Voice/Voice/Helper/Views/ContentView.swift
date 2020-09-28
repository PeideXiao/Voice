//
//  NaviView.swift
//  collectionViewTest
//
//  Created by Peide Xiao on 9/25/20.
//

import UIKit

protocol ContentViewDelegate: NSObjectProtocol {
    func collectionView(_ collectionView: UICollectionView, scrollTo index: Int, percent: CGFloat);
    func collectionView(_ collectionView: UICollectionView, didEndDecelerating index: Int);
}

class ContentView: UIView {
    
    var titles: [String]! {
        didSet {
            contentCollectionView.reloadData()
        }
    }
    
    var contentCollectionView: UICollectionView!
    let naviHeight:CGFloat = 40
    let naviBarHeight:CGFloat = 84
    weak var delegate: ContentViewDelegate? = nil
    
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
        let contentLayout = UICollectionViewFlowLayout()
        contentLayout.scrollDirection = .horizontal;
        contentLayout.minimumInteritemSpacing = 0
        contentLayout.minimumLineSpacing = 0;
        
        contentCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: contentLayout);
        contentCollectionView.dataSource = self;
        contentCollectionView?.delegate = self;
        contentCollectionView.register(UINib(nibName: "ContentCell", bundle: Bundle.main), forCellWithReuseIdentifier: "contentCell");
        contentCollectionView.isPagingEnabled = true;
        addSubview(contentCollectionView);
    }
    
    public func scrollContent(to index: Int) {
        contentCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true);
    }
    
    
}

extension ContentView :UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentCell", for: indexPath) as! ContentCell;
        cell.backgroundColor = UIColor.gray;
        cell.indexButton.setTitle("the \(indexPath.item + 1)th", for: .normal);
        cell.showHeader = indexPath.item == 0;
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: SCREEN_HEIGHT - naviBarHeight - naviHeight);
    }
    
}


extension ContentView: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / SCREEN_WIDTH
        let percent: CGFloat = index - CGFloat(Int(index)); 
        self.delegate?.collectionView(scrollView as! UICollectionView, scrollTo: Int(index), percent: percent)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = scrollView.contentOffset.x / SCREEN_WIDTH
        print("decelerating: \(index)")
        self.delegate?.collectionView(scrollView as! UICollectionView, didEndDecelerating: Int(index))
    }
}

class ContentCell: UICollectionViewCell {
    
    @IBOutlet weak var indexButton: UIButton!
    let images:[String] = ["01", "02","03"];
    
    var layout: UICollectionViewFlowLayout!
    var imageBrowserView: UICollectionView!
    var pageControl: UIPageControl!
    
    var showHeader:Bool = false {
        didSet {
            imageBrowserView.isHidden = !showHeader;
            pageControl.isHidden = !showHeader;
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        configureHeaderView();
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        imageBrowserView.frame = CGRect(x: 0, y: 10, width: SCREEN_WIDTH, height: 270);
        pageControl.frame =  CGRect(x: 0, y: imageBrowserView.frame.maxY, width: SCREEN_WIDTH, height: 30);
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        self.configureHeaderView();
    }
    
    func configureHeaderView() {
        layout = UICollectionViewFlowLayout();
        layout.scrollDirection = .horizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        
        imageBrowserView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        imageBrowserView.dataSource = self;
        imageBrowserView.delegate = self;
        imageBrowserView.isPagingEnabled = true;
        imageBrowserView.showsHorizontalScrollIndicator = false
        imageBrowserView.register(UINib(nibName: "ImageBrowserCell", bundle: Bundle.main), forCellWithReuseIdentifier: "imageBrowserCell");
        addSubview(imageBrowserView);
        
        pageControl = UIPageControl()
        pageControl.numberOfPages = 3;
        addSubview(pageControl);
        
        DispatchQueue.main.async {
            self.imageBrowserView.scrollToItem(at: IndexPath(item: self.images.count, section: 0), at: UICollectionView.ScrollPosition.right, animated: false)
        }
        
    }
    
}

extension ContentCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count * 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageBrowserCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageBrowserCell", for: indexPath) as! ImageBrowserCell;
        cell.imageView.image = UIImage(named: images[indexPath.item % images.count]);
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: 250);
    }
}

extension ContentCell: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
       
        
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let browserView: UICollectionView = scrollView as! UICollectionView;
        var offset: Int = Int(scrollView.contentOffset.x / SCREEN_WIDTH);
        
         
        if offset == 0 || offset == browserView.numberOfItems(inSection: 0) - 1 {
//            print("offset:\(offset)")
            offset = images.count - (offset == 0 ? 0 : 1);
            
        }
//        print("offset!!!:\(offset)")
        scrollView.contentOffset = CGPoint(x: CGFloat(offset) * SCREEN_WIDTH, y: 0);
        
    }
    
}

class ImageBrowserCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    
}
