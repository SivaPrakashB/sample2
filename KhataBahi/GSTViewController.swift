//
//  GSTViewController.swift
//  KhataBahi
//
//  Created by Narayan on 4/27/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
var dashBoardElementValueForFn:String=String()
var dashBoardCompanyName123:String=String()
var db_name:String=String()
class GSTViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        
        dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
 
 dashBoardCompanyName123=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        
       companyname12.text=dashBoardCompanyName123
        fnyear12.text="(\(dashBoardElementValueForFn))"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var companyname: UILabel!
    
    @IBOutlet weak var fnyear: UILabel!
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func b2b(_ sender: UIButton) {
        let urlForWebView="http://wservice.khatabahi.online/Process/GSTR1?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName123)&FnYear=\(dashBoardElementValueForFn)&rpt_no=r1_1"
            
            //serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
        
       
        UserDefaults.standard.set(urlForWebView, forKey: "gstUrlForWebView")
        let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "gstWebView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
       
    }
    
    
    
    @IBAction func B2Cl(_ sender: UIButton) {
        let urlForWebView="http://wservice.khatabahi.online/Process/GSTR1?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName123)&FnYear=\(dashBoardElementValueForFn)&rpt_no=r1_2"
        
        //serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
        
        
        UserDefaults.standard.set(urlForWebView, forKey: "gstUrlForWebView")
        let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "gstWebView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func CreditDebit(_ sender: UIButton) {
        let urlForWebView="http://wservice.khatabahi.online/Process/GSTR1?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName123)&FnYear=\(dashBoardElementValueForFn)&rpt_no=r1_4"
        
        //serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
        
        
        UserDefaults.standard.set(urlForWebView, forKey: "gstUrlForWebView")
        let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "gstWebView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    @IBAction func advancedAdjusted(_ sender: UIButton) {
        let urlForWebView="http://wservice.khatabahi.online/Process/GSTR1?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName123)&FnYear=\(dashBoardElementValueForFn)&rpt_no=r1_6"
        
        //serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
        
        
        UserDefaults.standard.set(urlForWebView, forKey: "gstUrlForWebView")
        let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "gstWebView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func adjusted(_ sender: UIButton) {
        let urlForWebView="http://wservice.khatabahi.online/Process/GSTR1?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName123)&FnYear=\(dashBoardElementValueForFn)&rpt_no=r1_5"
        
        //serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
        
        
        UserDefaults.standard.set(urlForWebView, forKey: "gstUrlForWebView")
        let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "gstWebView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func b2cs(_ sender: UIButton) {
        let urlForWebView="http://wservice.khatabahi.online/Process/GSTR1?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName123)&FnYear=\(dashBoardElementValueForFn)&rpt_no=r1_3"
        
        //serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
        
        
        UserDefaults.standard.set(urlForWebView, forKey: "gstUrlForWebView")
        let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "gstWebView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBAction func ExemptedAndnonGstOutward(_ sender: UIButton) {
        let urlForWebView="http://wservice.khatabahi.online/Process/GSTR1?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName123)&FnYear=\(dashBoardElementValueForFn)&rpt_no=r1_8"
        
        //serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
        
        
        UserDefaults.standard.set(urlForWebView, forKey: "gstUrlForWebView")
        let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "gstWebView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var fnyear12: UILabel!
    
    @IBOutlet weak var companyname12: UILabel!
    
    
    @IBAction func DocumentTaxPeriod(_ sender: UIButton) {
        let urlForWebView="http://wservice.khatabahi.online/Process/GSTR1?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName123)&FnYear=\(dashBoardElementValueForFn)&rpt_no=r1_7"
        
        //serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
        
        
        UserDefaults.standard.set(urlForWebView, forKey: "gstUrlForWebView")
        let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "gstWebView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBOutlet weak var exempted: UIButton!
    
    
    @IBOutlet weak var CDNUR: UIButton!
    
    
    
    
    
    @IBAction func CDNUR1(_ sender: UIButton) {
        let urlForWebView="http://wservice.khatabahi.online/Process/GSTR1?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName123)&FnYear=\(dashBoardElementValueForFn)&rpt_no=r1_9"
        
        //serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
        
        
        UserDefaults.standard.set(urlForWebView, forKey: "gstUrlForWebView")
        let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "gstWebView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    
    
    @IBAction func HSNO(_ sender: UIButton) {
        let urlForWebView="http://wservice.khatabahi.online/Process/GSTR1?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName123)&FnYear=\(dashBoardElementValueForFn)&rpt_no=r1_10"
        
        //serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)" as! String
        
        
        UserDefaults.standard.set(urlForWebView, forKey: "gstUrlForWebView")
        let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "gstWebView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    }
    
    
    
    
    
    
    
    
    
    
    
    

}
