//
//  HelpViewController.swift
//  BackbaseTestAdriana
//
//  Created by Adriana Ormaetxea on 04/05/2017.
//  Copyright © 2017 Mobiquity. All rights reserved.
//

import Foundation
import UIKit

class HelpViewController: UIViewController{
    
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        guard let url = Bundle.main.url(forResource: "help", withExtension: "html")
            else {
                print ("File reading error")
                return
        }
        
        let urlRequest = URLRequest(url: url)
        webView.loadRequest(urlRequest)
    }
    
}
