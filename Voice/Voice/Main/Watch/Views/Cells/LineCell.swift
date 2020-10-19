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
    @IBOutlet weak var seeMoreStackView: UIStackView!
    @IBOutlet weak var wordCollectionViewLayout: UICollectionViewFlowLayout! {
        didSet {
//            wordCollectionViewLayout.itemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    var line: CaptionLine! {
        didSet {
            self.seeMoreStackView.isHidden = line.editor == nil
            self.words = line.originalText.text.splitTo(with: " ")
            self.wordCollectionView.reloadData()
        }
    }
    
    var words:[Substring]?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        wordCollectionView.dataSource = self;
        wordCollectionView.delegate = self;
        wordCollectionViewLayout.minimumInteritemSpacing = 5;
        wordCollectionViewLayout.minimumLineSpacing = 5;
        wordCollectionView.register(UINib(nibName: "WordCell", bundle: Bundle.main), forCellWithReuseIdentifier: "wordCell")
       
    
    }

}

extension LineCell: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return words?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:WordCell = collectionView.dequeueReusableCell(withReuseIdentifier: "wordCell", for: indexPath) as! WordCell
         let word:String = String(self.words![indexPath.item])
        cell.wordLabel.text = word;
        
        return cell;
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let words = words else { return CGSize.zero }
        let word:String = String(words[indexPath.item])
        return CGSize(width: word.widthWithConstrainedHeight(20, UIFont(name: "AvenirNext-Regular", size: 16)!), height: 20)
    }
}



class WordCell: UICollectionViewCell {
    @IBOutlet weak var wordLabel: UILabel!

}
