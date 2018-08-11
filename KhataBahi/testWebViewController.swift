//
//  testWebViewController.swift
//  KhataBahi
//
//  Created by Narayan on 4/28/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class testWebViewController: UIViewController {

    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var webView123: UIWebView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func viewDidAppear(_ animated: Bool) {
        
    var pdf123
            =  UserDefaults.standard.object(forKey: "urlForWebView") as! String
        print(pdf123,"bvspRock")
        pdf123=pdf123.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!
        
        let url=NSURL(string:pdf123) as! URL
        
        
        let req=NSURLRequest(url: url as! URL)
        
        
        webView123.loadRequest(req as URLRequest)
        
        
    }

}
