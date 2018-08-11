//
//  changePasswordViewController123.swift
//  KhataBahi
//
//  Created by Narayan on 4/20/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class changePasswordViewController123: UIViewController,UITableViewDelegate,UITableViewDataSource {
    var fnlist=[String]()
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var selectCompanyName: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView1.isHidden=true
        selectCompanyName.layer.borderWidth=2
        selectCompanyName.layer.borderColor=UIColor.black.cgColor
        fnlist=UserDefaults.standard.object(forKey: "fnlist") as! [String]
        tableView1.isHidden=true
        selectCompanyName.setTitle("\(fnlist[0])", for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func selectCompanyName(_ sender: Any) { tableView1.delegate=self
        tableView1.dataSource=self
        if tableView1.isHidden == true
        {
            tableView1.isHidden=false
            
        }
        else{
            tableView1.isHidden=true
        }
        
        
    }
    
    
    @IBAction func okAction(_ sender: UIButton) {
        var fn:String=selectCompanyName.titleLabel?.text as! String
        print(fn,"bvsp Company Name")
        UserDefaults.standard.set(fn, forKey: "dashBoardElementValueForFn")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "dashBoard") as! UIViewController
        self.present(vc, animated: true, completion: nil)
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fnlist.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView1.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text="\(fnlist[indexPath.row])"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCompanyName.setTitle("\(fnlist[indexPath.row])", for: .normal)
        tableView1.isHidden=true
    }
    
}
