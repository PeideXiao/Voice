//
//  ViewController.swift
//  PDSwift
//
//  Created by Peide Xiao on 9/22/20.
//

import UIKit
import Alamofire
import RNCryptor
import MBProgressHUD
import SDWebImage
import Keychain

class DashboardViewController: UIViewController {

    var networkManager: NetworkManager!
    var questions:[Question] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getQuestions();
      
        let str = "23456aaa";
        print("\(str.isAlphanumeric)");
        
        let data = str.data(using: String.Encoding.utf8);
    
        let dataStr = String(data: data!, encoding: String.Encoding.utf8);
        
        print("dataStr: \(dataStr)")
        
        
        let arr = [3,4,5];
        UserDefaults.standard.setValue(arr, forKey: "hi");
        UserDefaults.standard.synchronize();
        
        
        let data1 = UserDefaults.standard.value(forKey: "hi");
        print("data: \(data1)")
        
        let hud = MBProgressHUD(view: self.view);
        hud.center = view.center;
        hud.mode = .text;
        hud.label.text = "loading";
        hud.show(animated: true);
        view.addSubview(hud)
        hud.hide(animated: true, afterDelay: 2.0);
        

        
        let strKeyChain = Keychain.load("username");
        if strKeyChain == nil {
            if Keychain.save("Kevin", forKey: "username"){
                print("save successfully");
            } else {
                print("keychain failed");
            }
        }
        print("str_keyChain:\(strKeyChain ?? "nil")")
        
    }
    
    func getQuestions() {
        networkManager = NetworkManager();
        
        networkManager.getQuestions { (questions, error) in
            DispatchQueue.main.async {
                if let error = error {
                    print("Error: \(error)");
                }
                
                if let questions = questions {
                    self.questions = questions;
                    
                    

                }
            }
        }
    }
}
        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
