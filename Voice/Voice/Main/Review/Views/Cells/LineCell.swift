//
//  LineCell.swift
//  Voice
//
//  Created by Peide Xiao on 10/6/20.
//

import UIKit

class LineCell: UITableViewCell {
    
    
    @IBOutlet weak var wordCollectionView: UICollectionView!
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var seeMoreButton: UIButton!
    @IBOutlet weak var wordCollectionViewLayout: UICollectionViewFlowLayout! {
        didSet {
//            wordCollectionViewLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var line: CaptionLine! {
        didSet {
            self.seeMoreButton.isHidden = line.editor == nil
            self.words = line.originalText.text.splitTo(with: " ")
            self.wordCollectionView.reloadData()
        }
    }
    
    var words:[Substring]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//        contentView.leftAnchor.constraint(equalTo: leftAnchor),
//        contentView.rightAnchor.constraint(equalTo: rightAnchor),
//        contentView.topAnchor.constraint(equalTo: topAnchor),
//        contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
//        ])
        wordCollectionView.dataSource = self;
        wordCollectionView.delegate = self;
        wordCollectionViewLayout.minimumInteritemSpacing = 2;
        wordCollectionViewLayout.minimumLineSpacing = 5;
       
        wordCollectionView.register(UINib(nibName: "WordCell", bundle: Bundle.main), forCellWithReuseIdentifier: "wordCell")
       
    
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        self.wordCollectionView.frame.size.height = self.wordCollectionView.contentSize.height
//        self.layoutIfNeeded()
//        wordCollectionView.frame.size.height = 80;
    }
}

extension LineCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:WordCell = collectionView.dequeueReusableCell(withReuseIdentifier: "wordCell", for: indexPath) as! WordCell
         let word:String = String(self.words![indexPath.item])
        cell.backgroundColor = UIColor.orange
        cell.wordLabel.text = word;
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let words = words else { return CGSize.zero }
        let word:String = String(words[indexPath.item])
        return CGSize(width: word.widthWithConstrainedHeight(20, UIFont.systemFont(ofSize: 15)) + 6.0, height: 20)
    }
}



class WordCell: UICollectionViewCell {
    @IBOutlet weak var wordLabel: UILabel!
    
//    override func preferredLayoutAttributesFitting(_ layoutAttributes: UICollectionViewLayoutAttributes) -> UICollectionViewLayoutAttributes {
//            setNeedsLayout()
//           layoutIfNeeded()
//           let size = contentView.systemLayoutSizeFitting(layoutAttributes.size)
//           var newFrame = layoutAttributes.frame
//           // Make any additional adjustments to the cell's frame
//           newFrame.size = size
//           layoutAttributes.frame = newFrame
//           return layoutAttributes
//    }
//    
}
