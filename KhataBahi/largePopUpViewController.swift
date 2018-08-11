//
//  largePopUpViewController.swift
//  KhataBahi
//
//  Created by Narayan on 3/29/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class largePopUpViewController: UIViewController {
    var message12:String!
   
    var a=UserDefaults.standard
    @IBOutlet weak var titleName: UILabel!
    @IBOutlet weak var text: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
message12=a.object(forKey: "message12") as! String
       text.text=message12
        
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
       UserDefaults.standard.set(nil, forKey: "loginUsername")
        UserDefaults.standard.set(nil, forKey: "loginPassword")
     
    }
    @IBAction func contactUs(_ sender: Any) {
        let sUrl = "googlechrome://www.khatabahi.com"
        UIApplication.shared.openURL(NSURL(string: sUrl) as! URL)
    }
    
    

}
