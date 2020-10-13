//
//  UIViewController_Extension.swift
//  Voice
//
//  Created by Peide Xiao on 9/29/20.
//

import Foundation
import UIKit
import MBProgressHUD


extension UIViewController {
    func showIndicator(withTitle title: String?, and description: String?) {

        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.label.text = title
        indicator.detailsLabel.text = description
        indicator.isUserInteractionEnabled = false
        indicator.show(animated: true)
    }
    
    func hideIndicator() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
    
    
    func showMessage(text: String) {
        let indicator = MBProgressHUD.showAdded(to: self.view, animated: true)
        indicator.mode = .text
        indicator.label.text = text
        indicator.show(animated: true)
        indicator.hide(animated: true, afterDelay: 2.0)
    }
}
