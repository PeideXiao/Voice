//
//  KeyVocabularyCell.swift
//  Voice
//
//  Created by Peide Xiao on 10/8/20.
//

import UIKit

class KeyVocabularyCell: UITableViewCell {
    
    @IBOutlet weak var indexLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var phonogramLabel: UILabel!
    @IBOutlet weak var wordButton: UIButton!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func showVacabularyDetail(_ sender: UIButton) {
        
    }
    
    public func configureSubviews(vocabulary: Vocabulary) {
        titleLabel.text = vocabulary.text
        if let definition = vocabulary.definitions.first {
            wordButton.setTitle(definition.text, for: UIControl.State.normal)
            phonogramLabel.text = "[" + definition.kk + "]"
        }
    }
}
