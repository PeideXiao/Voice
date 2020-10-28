//
//  ContentCell.swift
//  Voice
//
//  Created by Peide Xiao on 9/29/20.
//

import Foundation
import UIKit
import SDWebImage
import MJRefresh

protocol ContentCellDelegate: NSObjectProtocol {
    func tableView(_ tableView: UITableView, didSelect video: VideoModel)
}

class ContentCell: UICollectionViewCell {
    
    var header:UIView!
    var layout: UICollectionViewFlowLayout!
    var imageBrowserView: UICollectionView!
    var contentTableView: UITableView!
    var pageControl: UIPageControl!
    var timer: Timer?
    var index: Int = 0
    weak var delegate: ContentCellDelegate? = nil
    var showHeader:Bool = false {
        didSet {
            header.isHidden = !showHeader;
            contentTableView.tableHeaderView = showHeader ? header : nil;
            
            if showHeader {
                if timer == nil {
                    timer = Timer(timeInterval: 2.0, target: self, selector: #selector(scrollImageBrowser), userInfo: nil, repeats: true);
                    RunLoop.current.add(timer!, forMode: RunLoop.Mode.default);
                }
            }
        }
    }
    
    var contentCellType: ContentCellType = .video {
        
        didSet {
            switch contentCellType {
            case .video:
                self.contentTableView.rowHeight = 90
            default:
                self.contentTableView.estimatedRowHeight = 100
                self.contentTableView.rowHeight = UITableView.automaticDimension
                
            }
        }
        
    }
    
    var dailyPickItems:[DailyPickItem]? {
        didSet {
            imageBrowserView.reloadData();
            if dailyPickItems != nil {
                pageControl.numberOfPages = dailyPickItems!.count;
            }
        }
    }
    
    var items:[Any]?
    
    override init(frame: CGRect) {
        super.init(frame: frame);
        configureHeaderView();
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        header.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: IMAGE_BROWSER_HEIGHT + 10);
        imageBrowserView.frame = CGRect(x: 0, y: 0, width: self.contentView.bounds.width, height: IMAGE_BROWSER_HEIGHT);
        pageControl.frame =  CGRect(x: 0, y:IMAGE_BROWSER_HEIGHT, width: SCREEN_WIDTH, height: 10);
        contentTableView.frame = CGRect(x: 0, y: 0, width: SCREEN_WIDTH, height: self.contentView.bounds.height);
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
        self.configureHeaderView();
    }
    
    public func updateContentView(items:[Any], cellType: ContentCellType) {
        self.contentCellType = cellType
        self.items = items
        self.contentTableView.reloadData()
    }
    
    func configureHeaderView() {
        
        header = UIView()
        addSubview(header)
        
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
        header.addSubview(imageBrowserView);
        
        pageControl = UIPageControl()
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.darkGray
        pageControl.alpha = 0.5
        pageControl.backgroundColor = UIColor.white
        header.addSubview(pageControl)
        
        contentTableView = UITableView();
        contentTableView.backgroundColor = UIColor.white;
        contentTableView.dataSource = self;
        contentTableView.delegate = self;
        contentTableView.tableFooterView = UIView();
        contentTableView.register(UINib(nibName: "VideoContentCell", bundle: Bundle.main), forCellReuseIdentifier: "videoContentCell");
        contentTableView.register(UINib(nibName: "DictionaryWordCell", bundle: Bundle.main), forCellReuseIdentifier: "dictionarywordcell");
        contentTableView.register(UINib(nibName: "CaptionLineCell", bundle: Bundle.main), forCellReuseIdentifier: "captionlinecell");
        
        addSubview(contentTableView);
        
        
        let footer = MJRefreshAutoNormalFooter();
        footer.setRefreshingTarget(self, refreshingAction: #selector(refreshNotification));
        contentTableView.mj_footer = footer;
        
        DispatchQueue.main.async {
            guard let items = self.dailyPickItems else {
                return;
            }
            self.imageBrowserView.scrollToItem(at: IndexPath(item: items.count, section: 0), at: UICollectionView.ScrollPosition.right, animated: false)
        }
    }
    
    @objc func refreshNotification(){
        NotificationCenter.default.post(name: NSNotification.Name(NOTIFICATION_FOOTER_REFRESH), object: nil, userInfo: nil);
        contentTableView.mj_footer!.state = .idle;
    }
    
    @objc func scrollImageBrowser() {
        guard let items = self.dailyPickItems else {
            return;
        }
        
        index += 1;
        
        let indexPath = IndexPath(item: index % items.count, section: 0);
        self.imageBrowserView.scrollToItem(at: indexPath, at: UICollectionView.ScrollPosition.centeredHorizontally, animated: false);
        self.pageControl.currentPage = index % items.count;
    }
}


extension ContentCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (dailyPickItems?.count ?? 0 ) * 2;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ImageBrowserCell = collectionView.dequeueReusableCell(withReuseIdentifier: "imageBrowserCell", for: indexPath) as! ImageBrowserCell;
        guard let items = dailyPickItems else {
            return cell;
        }
        
        cell.dailyPickItem = items[indexPath.item % items.count];
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: SCREEN_WIDTH, height: IMAGE_BROWSER_HEIGHT);
    }
}

extension ContentCell: UIScrollViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        guard let items = dailyPickItems else {
            return;
        }
        
        if let browserView: UICollectionView = scrollView as? UICollectionView {
            var offset: Int = Int(scrollView.contentOffset.x / SCREEN_WIDTH);
            var currentPage = 0;
            if offset >= items.count {
                currentPage = offset - items.count;
            } else {
                currentPage = offset;
            }
            self.pageControl.currentPage = currentPage;

            
            if offset == 0 || offset == browserView.numberOfItems(inSection: 0) - 1 {
                offset = items.count - (offset == 0 ? 0 : 1);
            }
            
            scrollView.contentOffset = CGPoint(x: CGFloat(offset) * SCREEN_WIDTH, y: 0);
        }
    }
}


extension ContentCell: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch self.contentCellType {
        case .video:
            let cell = tableView.dequeueReusableCell(withIdentifier: "videoContentCell") as! VideoContentCell;
            if let videoModel: VideoModel = self.items?[indexPath.row] as? VideoModel {
                cell.videoModel = videoModel;
                cell.selectionStyle = .none;
                cell.backgroundColor = UIColor.white;
            }
            return cell;
        case .word:
            let cell = tableView.dequeueReusableCell(withIdentifier: "dictionarywordcell") as! DictionaryWordCell;
            if let word: DictionaryWord = self.items?[indexPath.row] as? DictionaryWord {
                cell.word = word
                cell.selectionStyle = .none;
                cell.backgroundColor = UIColor.white;
            }
            return cell;
          
        case .captionLine :
            let cell = tableView.dequeueReusableCell(withIdentifier: "captionlinecell") as! CaptionLineCell;
            if let captionLine: CaptionLine = self.items?[indexPath.row] as? CaptionLine {
                cell.captionLine = captionLine
                cell.selectionStyle = .none;
                cell.backgroundColor = UIColor.white;
            }
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch self.contentCellType {
        case .video:
            if let videoModel: VideoModel = self.items?[indexPath.row] as? VideoModel {
                self.delegate?.tableView(tableView, didSelect: videoModel);
            }

        case .word:
            if let _: DictionaryWord = self.items?[indexPath.row] as? DictionaryWord {
            }
          
        case .captionLine :
            if let _: CaptionLine = self.items?[indexPath.row] as? CaptionLine {
            }
        }
    }
}



class ImageBrowserCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleOfHeader: UILabel!
    @IBOutlet weak var blurEffiectView: UIVisualEffectView!
    @IBOutlet weak var title: UILabel!
    
    var dailyPickItem: DailyPickItem! {
        didSet {
            imageView.sd_setImage(with: URL(string: dailyPickItem.imageUrl), completed: nil);
            titleOfHeader.text = dailyPickItem.labelText;
            title.text = dailyPickItem.title;
        }
    }
}



class VideoContentCell: UITableViewCell {
    
    @IBOutlet weak var previewImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var levelLabel: UILabel!
    
    
    var videoModel: VideoModel! {
        didSet {
            previewImageView.sd_setImage(with: URL(string: videoModel.imageUrl), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions.highPriority, context: nil)
            titleLabel.text = videoModel.title;
            durationLabel.text = "🕒 " + videoModel.durationText;
            levelLabel.text = " \(videoModel.CEFRLevelTag) ";
            
            var color:UIColor = .white;
            switch videoModel.CEFRLevel {
            case "B1":
                color = UIColor.systemYellow;
            case "A2":
                color = UIColor.systemGreen;
            default:
                color = UIColor.systemRed;
            }
            levelLabel.backgroundColor = color;
        }
    }
}
