//
//  FirstSectionHeaderView.swift
//  Voice
//
//  Created by Peide Xiao on 10/7/20.
//

import UIKit

class FirstSectionHeaderView: UITableViewHeaderFooterView {

    var titleBtn: UIButton!
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier);
        configureSubviews()
    }
    
    func configureSubviews() {
        titleBtn = UIButton();
        titleBtn.titleLabel?.font = UIFont(name: "AvenirNext-Medium", size: 15);
        titleBtn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -5, bottom: 0, right: 0);
        titleBtn.setTitleColor(UIColor.black, for: UIControl.State.normal)
        contentView.addSubview(titleBtn);
        
        titleBtn.translatesAutoresizingMaskIntoConstraints = false;
        
        NSLayoutConstraint.activate([
            titleBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            titleBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ]);
        
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
