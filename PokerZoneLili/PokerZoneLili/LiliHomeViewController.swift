//
//  HomeVC.swift
//  PokerZoneLili
//
//  Created by PokerZoneLili on 2025/3/7.
//


import UIKit
import StoreKit

class LiliHomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnRate(_ sender: Any) {
        
        SKStoreReviewController.requestReview()
        
    }
    

}
