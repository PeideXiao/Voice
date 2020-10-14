//
//  CaptionLlineCell.swift
//  Voice
//
//  Created by Peide Xiao on 10/12/20.
//

import UIKit

class CaptionLineCell: UITableViewCell {
    
    @IBOutlet weak var lineLabel: UILabel!
    var captionLine: CaptionLine? {
        didSet {
            lineLabel.text = captionLine?.originalText.text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func play(_ sender: UIButton) {
    }
    @IBAction func like(_ sender: UIButton) {
    }
    
}
