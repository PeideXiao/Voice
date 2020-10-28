//
//  NaviView.swift
//  collectionViewTest
//
//  Created by Peide Xiao on 9/25/20.
//

import UIKit


enum ContentCellType {
    case video
    case word
    case captionLine
}

protocol ContentViewDelegate: NSObjectProtocol {
    func collectionView(_ collectionView: UICollectionView, scrollTo index: Int, percent: CGFloat);
    func collectionView(_ collectionView: UICollectionView, didEndDecelerating index: Int);
    func didSelect(video: VideoModel)
}

class ContentView: UIView {
    
    var dailyPickItems: [DailyPickItem]? {
        didSet {
            updateImageBrowser();
        }
    }
    
    var items:[Any]? {
        didSet {
            contentCollectionView.reloadData()
        }
    }
    
    var isHomePage: Bool = false    
    var contentCollectionView: UICollectionView!
    weak var delegate: ContentViewDelegate? = nil
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureSubviews();
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configureSubviews() {
        let contentLayout = UICollectionViewFlowLayout()
        contentLayout.scrollDirection = .horizontal;
        contentLayout.minimumInteritemSpacing = 0
        contentLayout.minimumLineSpacing = 0;
        contentLayout.itemSize = CGSize(width: self.bounds.width, height: self.bounds.height);
        
        contentCollectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.height), collectionViewLayout: contentLayout);
        contentCollectionView.dataSource = self;
        contentCollectionView?.delegate = self;
        contentCollectionView.register(UINib(nibName: "ContentCell", bundle: Bundle.main), forCellWithReuseIdentifier: "contentCell");
        contentCollectionView.isPagingEnabled = true;
        contentCollectionView.backgroundColor = UIColor.white
        addSubview(contentCollectionView);
    }
    
    private func updateImageBrowser() {
        self.contentCollectionView.reloadData();
    }
    
    public func updateContentView(items:[Any], cellType: ContentCellType) {
        DispatchQueue.main.async {
            if let cell:ContentCell = self.contentCollectionView.visibleCells.first as? ContentCell{
                cell.updateContentView(items: items, cellType: cellType)
            }
        }
    }
    
    public func scrollContent(to index: Int) {
        contentCollectionView.scrollToItem(at: IndexPath(item: index, section: 0), at: UICollectionView.ScrollPosition.bottom, animated: true);
    }
}

extension ContentView :UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items?.count ?? 0;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ContentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentCell", for: indexPath) as! ContentCell;
        cell.backgroundColor = UIColor.white;
        cell.showHeader = (indexPath.item == 0 && isHomePage);
        cell.delegate = self;
        if indexPath.item == 0 {
            cell.dailyPickItems = self.dailyPickItems;
        }
        return cell;
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


extension ContentView: ContentCellDelegate {
    func tableView(_ tableView: UITableView, didSelect video: VideoModel) {
        self.delegate?.didSelect(video: video)
    }
}
