//
//  RankingViewController.swift
//  Voice
//
//  Created by Peide Xiao on 9/29/20.
//

import UIKit


class RankingViewController: UIViewController {

    var header: RankingHeader!
    var rankingTableView: UITableView!
    var footer: RankingFooter!
    var rankList: RankList?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureTableView()
        loadRankRemainTime()
        loadUserRankList()
    }
    
    func loadRankRemainTime() {
        self.showIndicator(withTitle: nil, and: nil);
        NetworkManager.sharedInstance.getRemainTime { (remainTime, error) in
            DispatchQueue.main.async {
                self.hideIndicator();
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let remainTime = remainTime {
                    self.header.remainTime = remainTime.remainTime
                }
            }
        }
    }
    
    func loadUserRankList() {
        self.showIndicator(withTitle: nil, and: nil);
        NetworkManager.sharedInstance.getUserRankingList { (rank, error) in
            DispatchQueue.main.async {
                self.hideIndicator();
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let rank = rank {
                    self.rankList = rank
                    self.footer.rankList = rank
                    self.rankingTableView.reloadData()
                }
            }
        }
    }
    
    
    func configureTableView() {
        rankingTableView = UITableView(frame: CGRect(x: 0, y: STATUS_BAR_Hight + NAVI_BAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - STATUS_BAR_Hight - NAVI_BAR_HEIGHT - TAB_BAR_HEIGHT))
        rankingTableView.dataSource = self
        rankingTableView.delegate = self
        rankingTableView.separatorStyle = .none
        rankingTableView.register(UINib(nibName: "RankDetailCell", bundle: Bundle.main), forCellReuseIdentifier: "rankdetailcell");
        view.addSubview(rankingTableView)
        
        if let header: RankingHeader = Bundle.main.loadNibNamed("RankingHeader", owner: nil, options: nil)?.first as? RankingHeader {
            self.header = header
            rankingTableView.tableHeaderView = header
        }
        
        if let footer: RankingFooter = Bundle.main.loadNibNamed("RankingFooter", owner: nil, options: nil)?.first as? RankingFooter {
            self.footer = footer
            rankingTableView.tableFooterView = footer
        }
    }
}

extension RankingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.rankList?.today.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: RankDetailCell = tableView.dequeueReusableCell(withIdentifier: "rankdetailcell") as! RankDetailCell
        
        guard let rankList = self.rankList?.today else { return cell }
        var rankItem = rankList[indexPath.row];
        rankItem.showEllipsis = (indexPath.row == rankList.count - 3)
        cell.rankItem = rankItem
        return cell
    }
}
