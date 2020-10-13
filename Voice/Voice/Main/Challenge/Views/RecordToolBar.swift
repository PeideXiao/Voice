//
//  recordToolBar.swift
//  Voice
//
//  Created by Peide Xiao on 10/8/20.
//

import UIKit

protocol RecordToolBarDelegate: NSObjectProtocol {
    func recording()
    func sendComment(_ text: String)
}

class RecordToolBar: UIView {

    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var inputTextfield: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    
    weak var delegate: RecordToolBarDelegate? = nil

    @IBAction func recording(_ sender: Any) {
        delegate?.recording()
    }
    
    @IBAction func comment(_ sender: UIButton) {
        delegate?.sendComment(inputTextfield.text ?? "")
    }
    
}
