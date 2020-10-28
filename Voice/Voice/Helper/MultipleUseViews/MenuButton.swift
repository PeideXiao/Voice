//
//  MenuButton.swift
//  Voice
//
//  Created by Peide Xiao on 10/1/20.
//

import UIKit

class MenuItem: UIControl {
    

    override init(frame: CGRect) {
        super.init(frame: frame);
        
       
    }
    
     init(frame: CGRect, imageName: String, count: Int, title: String) {
        super.init(frame: frame);
        
        if let menuBtn: MenuButton =  Bundle.main.loadNibNamed("MenuButton", owner: nil, options: nil)?.last as? MenuButton {
            menuBtn.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height);
            self.addSubview(menuBtn)
            
            menuBtn.image = UIImage(named: imageName)
            menuBtn.title = title
            menuBtn.count = String(count)
        }
    }
    
    
    required init?(coder: NSCoder) {
        super.init(coder: coder);
    }
    
}

class MenuButton: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var levelCountLabel: UILabel!
    
    var image: UIImage? {
        didSet {
            iconImageView.image = image
        }
    }
    
    var title: String? {
        didSet{
            titleLabel.text = title?.capitalized
        }
    }
    
    var count: String? {
        didSet {
            levelCountLabel.text = count
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib();
        self.layer.shadowColor = UIColor.darkGray.cgColor
        self.layer.shadowOffset = .zero
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 2, height: 2);
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
    }
    
    
}
