//
//  large2PopUpViewController.swift
//  KhataBahi
//
//  Created by Narayan on 3/30/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class large2PopUpViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        var message12:String=UserDefaults.standard.object(forKey: "message12") as! String
        textView.text=message12
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func visit(_ sender: UIButton) {
        let sUrl = "googlechrome://www.khatabahi.com"
        UIApplication.shared.openURL(NSURL(string: sUrl) as! URL)
    }
    
    
    
    
    @IBAction func skip(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "dashBoard")
        self.present(vc, animated: true, completion: nil)
       
    }
    
    
    
    
    
    
    
}
