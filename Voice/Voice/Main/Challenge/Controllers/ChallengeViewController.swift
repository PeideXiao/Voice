//
//  RankingViewController.swift
//  Voice
//
//  Created by Peide Xiao on 9/29/20.
//

import UIKit

class ChallengeViewController: UIViewController {
    
    
    // ============================================================================
    // MARK: - Properties
    // ============================================================================
    
    var challenges: [ChallengeModel]?
    
    // IBOutlets
    
    // ============================================================================
    // MARK: - Initialization
    // ============================================================================
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Pronunciation Challenge"
        configureSubviews()
        getPronunciationChallenges()
    }
    
    
    // ============================================================================
    // MARK: - IBActions
    // ============================================================================
    
 
    
    // ============================================================================
    // MARK: - Action Methods
    // ============================================================================
    
    // API Actions
    // ---------------------------------------------------------------------------------
    func getPronunciationChallenges() {
        self.showIndicator(withTitle: nil, and: nil)
        Webservice.sharedInstance.getPronunciationChallenges(offset: 0) { (challengeModels, error) in
            DispatchQueue.main.async {
                self.hideIndicator();
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let challenges = challengeModels {
                    self.challenges = challenges
                    self.challengeTableView.reloadData()
                }
            }
        }
    }
    
    // General Actions
    // ---------------------------------------------------------------------------------
    
    // View Controller Displaying
    // ---------------------------------------------------------------------------------
    
    
    // ============================================================================
    // MARK: - Helper Methods
    // ============================================================================
    
    func configureSubviews(){
        view.addSubview(self.challengeTableView);
    }
    
    lazy var challengeTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: STATUS_BAR_Hight + NAVI_BAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - STATUS_BAR_Hight - NAVI_BAR_HEIGHT - TAB_BAR_HEIGHT))
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
        
        tableView.register(UINib(nibName: "ChallengeHeaderCell", bundle: Bundle.main), forCellReuseIdentifier: "ChallengeHeaderCell")
        tableView.register(UINib(nibName: "ChallengeContentCell", bundle: Bundle.main), forCellReuseIdentifier: "ChallengeContentCell")
        tableView.register(FirstSectionHeaderView.self, forHeaderFooterViewReuseIdentifier: "FirstSectionHeaderView")
        return tableView
    }()
}


// ============================================================================
// MARK: - Extensions
// ============================================================================

extension ChallengeViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1;
        default:
            return ((self.challenges?.count) ?? 1) - 1;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
   
        if indexPath.section == 0 {
            let fCell:ChallengeHeaderCell = tableView.dequeueReusableCell(withIdentifier: "ChallengeHeaderCell") as! ChallengeHeaderCell;
     
            guard let challenges = self.challenges else {
                return fCell;
            }
            
            let firstChallenge: ChallengeModel = challenges[0];
            fCell.configureSubviews(challenge: firstChallenge);
            return fCell;
            
        } else {
            let cell:ChallengeContentCell = tableView.dequeueReusableCell(withIdentifier: "ChallengeContentCell") as! ChallengeContentCell;
            guard let challenges = self.challenges else {
                return cell;
            }
            
            let challenge: ChallengeModel = challenges[indexPath.row + 1];
            cell.configureSubviews(challenge: challenge);
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return SCREEN_WIDTH / Video_WH_Ratio;
        } else {
            return 100;
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
            if let view: FirstSectionHeaderView = tableView.dequeueReusableHeaderFooterView(withIdentifier: "FirstSectionHeaderView") as? FirstSectionHeaderView {
                if section == 0 {
                    view.titleBtn.setTitle("Challenges recorded: 0", for: UIControl.State.normal)
                    view.titleBtn.setImage(UIImage(named: "mountains"), for: UIControl.State.normal)
                } else {
                    view.titleBtn.setImage(nil, for: UIControl.State.normal)
                    view.titleBtn.setTitle("Past Challenges", for: UIControl.State.normal);
                }
                return view;
            }
        return nil;
    
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40;
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let challenges = self.challenges else {
            return ;
        }
        
        let challenge: ChallengeModel = challenges[indexPath.row + 1];
        let challengeDetailVC: ChallengeDetailViewController = ChallengeDetailViewController();
        challengeDetailVC.challengeModel = challenge;
        self.navigationController?.pushViewController(challengeDetailVC, animated: true);
    }
}
