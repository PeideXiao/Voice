
//  VideoPlaylistsViewController.swift
//  SmartMobile
//
//  Created by Peide Xiao on 2/21/20.
//  Copyright © 2020 SmartMobile. All rights reserved.
//

import UIKit


class ChallengeDetailViewController: BaseViewController {
    
    
    // ============================================================================
    // MARK: - Properties
    // ============================================================================
    
    var challengeDetailHeader: ChallengeDetailHeader!
    var challengeDetailTableView: UITableView!
    var challengeModel: ChallengeModel! {
        didSet {
            loadChallengeDetail(id: challengeModel.id)
            loadOthersComments(id: challengeModel.id)
        }
    }
    
    var challengeDetail: ChallengeDetailModel?
    var comments: [Comment] = []
    var myComments: [Comment] = []
    let toolBarHeight: CGFloat = 44.0
    let recordPanelHeight: CGFloat = 180.0
    
    // IBOutlets
    
    // ============================================================================
    // MARK: - Initialization
    // ============================================================================
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSubviews();
        registerNotifications();
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        updateTableHeaderView()
        self.challengeDetailTableView.reloadData()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    // ============================================================================
    // MARK: - IBActions
    // ============================================================================
    
    
    
    // ============================================================================
    // MARK: - Action Methods
    // ============================================================================
    
    // API Actions
    // ---------------------------------------------------------------------------------
    
    func loadChallengeDetail(id: Int) {
        let hud = self.showIndicator(withTitle: nil, and: nil);
        Webservice.sharedInstance.getChallengeDetail(id: id) { (challengeDetail, error) in
            DispatchQueue.main.async {
                self.hideIndicator(hud: hud);
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let challengeDetail = challengeDetail {
                    self.challengeDetail = challengeDetail
                    self.challengeDetailHeader.configureSubviews(detail: challengeDetail)
                    if let myComments = challengeDetail.myComments {
                        self.myComments = myComments
                    }
                    self.challengeDetailTableView.reloadData()
                }
            }
        }
    }
    
    func loadOthersComments(id: Int) {
        let hud = self.showIndicator(withTitle: nil, and: nil);
        Webservice.sharedInstance.getComments(id: id, mode: FetchMode.Others, offset: 0) { (comments, error) in
            DispatchQueue.main.async {
                self.hideIndicator(hud: hud);
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let comments = comments {
                    self.comments = comments
                    self.challengeDetailTableView.reloadSections([2], with: UITableView.RowAnimation.none)
                }
            }
        }
    }
    
    func submitComment(data: Data?, text: String) {
        let hud = self.showIndicator(withTitle: nil, and: nil);
        Webservice.sharedInstance.submitComment(id: challengeModel.id, data: data, text: text) { (comment, error) in
            DispatchQueue.main.async {
                self.hideIndicator(hud: hud);
                if let error = error {
                    print("\(error)")
                    self.showMessage(text: error)
                    return;
                }
                
                if let comment = comment {
                    self.myComments.append(comment)
                    self.challengeDetailTableView.reloadSections([1], with: UITableView.RowAnimation.none)
                    self.displayRecordingViews(show: false)
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
    
    func configureSubviews() {
        self.title = "Pronuncitaion Challenge"
        self.hidesBottomBarWhenPushed = true
        challengeDetailHeader = Bundle.main.loadNibNamed("ChallengeDetailHeader", owner: nil, options: nil)?.first as? ChallengeDetailHeader
        challengeDetailHeader.frame = CGRect(x: 0, y: STATUS_BAR_Hight + NAVI_BAR_HEIGHT, width: SCREEN_WIDTH, height: .zero);
        
        challengeDetailTableView = UITableView(frame: CGRect(x: 0, y: STATUS_BAR_Hight + NAVI_BAR_HEIGHT, width: SCREEN_WIDTH, height: SCREEN_HEIGHT - toolBarHeight - STATUS_BAR_Hight - NAVI_BAR_HEIGHT));
        challengeDetailTableView.dataSource = self;
        challengeDetailTableView.delegate = self;
        challengeDetailTableView.estimatedRowHeight = 100;
        challengeDetailTableView.rowHeight = UITableView.automaticDimension;
        challengeDetailTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        challengeDetailTableView.tableHeaderView = challengeDetailHeader
        challengeDetailTableView.register(UINib(nibName: "KeyVocabularyCell", bundle: Bundle.main), forCellReuseIdentifier: "keyvovabulary")
        challengeDetailTableView.register(UINib(nibName: "CommentCell", bundle: Bundle.main), forCellReuseIdentifier: "comment")
        challengeDetailTableView.register(UINib(nibName: "RecordCell", bundle: Bundle.main), forCellReuseIdentifier: "recording")
        view.addSubview(challengeDetailTableView)
        
        view.addSubview(self.recordToolBar);
    }
    
    fileprivate func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    fileprivate func updateTableHeaderView(){
        if let header = self.challengeDetailTableView.tableHeaderView {
            header.frame.size.height = header.systemLayoutSizeFitting(CGSize(width: SCREEN_WIDTH, height: 0)).height
        }
    }
    
    lazy var recordToolBar: RecordToolBar = {
        if let toolBar = Bundle.main.loadNibNamed("RecordToolBar", owner: nil, options: nil)?.last as? RecordToolBar {
            toolBar.frame = CGRect(x: 0, y: SCREEN_HEIGHT - toolBarHeight, width: SCREEN_WIDTH, height: toolBarHeight)
            toolBar.delegate = self
            return toolBar;
        }
        else { return RecordToolBar() }
    }()
    
    
    lazy var recordPanel: RecordPanel = {
        if let panel: RecordPanel = Bundle.main.loadNibNamed("RecordPanel", owner: nil, options: nil)?.last as? RecordPanel {
            panel.frame = CGRect(x: 0, y: SCREEN_HEIGHT, width: SCREEN_WIDTH, height: recordPanelHeight);
            self.view.addSubview(panel)
            return panel
        }
        else { return RecordPanel() }
    }()
    
    
    // ============================================================================
    // MARK: - Keyboard Handling
    // ============================================================================
    
    @objc func keyboardWillShow(_ notification:Notification) {
        let info:NSDictionary = notification.userInfo! as NSDictionary;
        let kbSize:CGSize = (info.object(forKey: UIResponder.keyboardFrameEndUserInfoKey)! as AnyObject).cgRectValue.size;
        let timeInteval: TimeInterval = info.object(forKey: UIResponder.keyboardAnimationDurationUserInfoKey)! as! TimeInterval;
        print(timeInteval)
        
        UIView.animate(withDuration: timeInteval) {
            self.recordToolBar.frame.origin.y =  SCREEN_HEIGHT - kbSize.height - self.toolBarHeight
            
        }
        
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
    
        UIView.animate(withDuration: 0.25) {
            self.recordToolBar.frame.origin.y = SCREEN_HEIGHT - self.toolBarHeight
        }
        self.displayRecordPanel(isHidden: true)

    }
    
    
    func displayRecordingViews(show: Bool) {
        
        displayRecordPanel(isHidden: !show)
        displayRecordTooBar(onBottom: !show)
        
        self.challengeDetailTableView.contentSize.height += show ? (toolBarHeight + recordPanelHeight) : (-toolBarHeight - recordPanelHeight)
    }
    
    
    func displayRecordTooBar(onBottom: Bool) {
        self.recordToolBar.frame.origin.y = onBottom ? SCREEN_HEIGHT - toolBarHeight : SCREEN_HEIGHT - recordPanelHeight - toolBarHeight
    }
    
    func displayRecordPanel(isHidden: Bool) {
        self.recordPanel.frame.origin.y = isHidden ? SCREEN_HEIGHT : SCREEN_HEIGHT - recordPanelHeight
    }
    
}

// ============================================================================
// MARK: - Extensions
// ============================================================================

extension ChallengeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return self.challengeDetail?.vocabularies.count ?? 0
        case 1:
            return 1
        default:
            return self.comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell: KeyVocabularyCell = tableView.dequeueReusableCell(withIdentifier: "keyvovabulary") as! KeyVocabularyCell
            cell.selectionStyle = .none
            cell.indexLabel.text = "\(indexPath.row + 1)."
            if let vocabulary: Vocabulary = self.challengeDetail?.vocabularies[indexPath.row] {
                cell.configureSubviews(vocabulary: vocabulary)
            }
            return cell
            
        case 1:
            
            if myComments.count > 0 {
                let cell: CommentCell = tableView.dequeueReusableCell(withIdentifier: "comment") as! CommentCell
                cell.selectionStyle = .none
                var comment: Comment? = myComments.first
                comment?.mode = FetchMode.Mine
                cell.configureSubviews(comment: comment)
                return cell;
            } else {
                let cell: RecordCell = tableView.dequeueReusableCell(withIdentifier: "recording") as! RecordCell
                cell.delegate = self
                cell.selectionStyle = .none
                return cell;
            }
            
        default:
            let cell: CommentCell = tableView.dequeueReusableCell(withIdentifier: "comment") as! CommentCell
            cell.selectionStyle = .none
            var comment: Comment? = self.comments[indexPath.row]
            comment?.mode = FetchMode.Others
            cell.configureSubviews(comment: comment)
            return cell;
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Key Vocabulary"
        case 1:
            return "Record"
        default:
            return "Other Replies (\(self.comments.count))"
        }
    }
}

extension ChallengeDetailViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.recordToolBar.inputTextfield.resignFirstResponder()
        displayRecordPanel(isHidden: true)
        displayRecordTooBar(onBottom: true)
    }
}


extension ChallengeDetailViewController: RecordToolBarDelegate {
    func recording() {
        self.view.endEditing(true)
        displayRecordTooBar(onBottom: false)
        displayRecordPanel(isHidden: false)
    }
    
    func sendComment(_ text: String) {
        let data = recordPanel.audioData
        
        if data == nil && text == "" {
            self.showMessage(text: "comment is nil")
            return
        }
        
        self.submitComment(data: data, text: text)
    }
}


extension ChallengeDetailViewController: RecordCellDelegate {
    func record() {
        self.displayRecordingViews(show: true)
    }
}
