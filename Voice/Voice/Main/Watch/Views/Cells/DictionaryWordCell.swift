//
//  DictionaryWordCell.swift
//  Voice
//
//  Created by Peide Xiao on 10/12/20.
//

import UIKit

class DictionaryWordCell: UITableViewCell {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var USPhonogramButton: UIButton!
    @IBOutlet weak var UKPhonogramButton: UIButton!
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var definitionTableView: SelfSizedTableView!
    
    var definitions = [[Definition]]()
    
    var word: DictionaryWord? {
        didSet {
            updateSubviews()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        definitionTableView.dataSource = self
        definitionTableView.delegate = self
        definitionTableView.rowHeight = 20
        definitionTableView.separatorStyle = .none
        definitionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "definitioncell")
       
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.USPhonogramButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(self.USPhonogramButton.imageView!.bounds.width), bottom: 0, right: self.USPhonogramButton.imageView!.bounds.width)
        self.USPhonogramButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.USPhonogramButton.titleLabel!.bounds.width, bottom: 0, right: -self.USPhonogramButton.titleLabel!.bounds.width)
        self.UKPhonogramButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: -(self.UKPhonogramButton.imageView!.bounds.width), bottom: 0, right: self.UKPhonogramButton.imageView!.bounds.width)
        self.UKPhonogramButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.UKPhonogramButton.titleLabel!.bounds.width, bottom: 0, right: -self.UKPhonogramButton.titleLabel!.bounds.width)
    }


    @IBAction func like(_ sender: UIButton) {
    }
    @IBAction func review(_ sender: UIButton) {
    }
    @IBAction func US(_ sender: UIButton) {
        guard let audioPath = self.word?.definitions.first?.pronunciationUsMp3 else { return }
        AudioPlayer.sharedInstance.play(with: URL(string: audioPath))
        
    }
    @IBAction func UK(_ sender: UIButton) {
        guard let audioPath = self.word?.definitions.first?.pronunciationUkMp3 else { return }
        AudioPlayer.sharedInstance.play(with: URL(string: audioPath))
    }
    
    
    func updateSubviews() {
        
        guard let dictionaryWord = word else { return }
        wordLabel.text = dictionaryWord.text
        
        levelLabel.text = " \(dictionaryWord.CEFRLevelTag) ";
        var color:UIColor = .white;
        switch dictionaryWord.CEFRLevelTag {
        case "B1":
            color = UIColor.systemYellow;
        case "A2":
            color = UIColor.systemGreen;
        default:
            color = UIColor.systemRed;
        }
        levelLabel.backgroundColor = color;
        
        
        self.USPhonogramButton.setTitle("US" + dictionaryWord.definitions.first!.pronunciationUs, for: .normal)
        self.UKPhonogramButton.setTitle("UK" + dictionaryWord.definitions.first!.pronunciationUk, for: .normal)
        
        definitions.removeAll();
        guard let definitionModels = word?.definitions else { return }
        var lastDefinition: Definition? = nil
        
        for definition: Definition in definitionModels {
            if definition.posFullName != lastDefinition?.posFullName {
                let temp = [Definition]()
                definitions.append(temp)
                lastDefinition = definition
            }
            definitions[definitions.endIndex - 1].append(definition)
        }
        
        self.definitionTableView.reloadData()
    }
}


extension DictionaryWordCell: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
       return self.definitions.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.definitions[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "definitioncell")!
        let definition:Definition = self.definitions[indexPath.section][indexPath.row];
        cell.textLabel?.text = definition.englishDefinition
        cell.textLabel?.font = UIFont.systemFont(ofSize: 13)
        cell.textLabel?.textColor = UIColor.darkGray
        cell.imageView?.image = UIImage(named: "tag")
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if let header: DefinitionHeader = Bundle.main.loadNibNamed("DefinitionHeader", owner: nil, options: nil)?.first as? DefinitionHeader {
            header.titleLabel.text = self.definitions[section].first?.posFullName;
            return header
        }
        return nil
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 15;
    }
}
