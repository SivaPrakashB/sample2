//
//  logOutViewController.swift
//  KhataBahi
//
//  Created by Narayan on 3/31/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class logOutViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func yes(_ sender: UIButton) {
       UserDefaults.standard.set("yes", forKey: "logoutStatus")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "login") as! UIViewController
        self.present(vc, animated: true, completion: nil)
       
    }
    

    @IBAction func no(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
