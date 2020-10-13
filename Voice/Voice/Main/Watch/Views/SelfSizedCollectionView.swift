//
//  SelfSizedCollectionView.swift
//  Voice
//
//  Created by Peide Xiao on 10/6/20.
//

import Foundation
import UIKit

class SelfSizedCollectionView: UICollectionView {
    
    override var contentSize: CGSize {
        didSet {
            if (oldValue != contentSize) {
                self.invalidateIntrinsicContentSize();
            }
        }
    }
    
    override var intrinsicContentSize: CGSize {
        return CGSize(width:self.contentSize.width, height: self.contentSize.height);
    }
}
