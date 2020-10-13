//
//  RecordCell.swift
//  Voice
//
//  Created by Peide Xiao on 10/8/20.
//

import UIKit

protocol RecordCellDelegate: NSObjectProtocol {
    func record()
}

class RecordCell: UITableViewCell {
    
    weak var delegate: RecordCellDelegate? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func reord(_ sender: UIButton) {
        delegate?.record()
    }
}
