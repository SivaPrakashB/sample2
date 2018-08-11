//
//  tableView1Cell.swift
//  KhataBahi
//
//  Created by Narayan on 4/2/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class tableView1Cell: UITableViewCell,UICollectionViewDelegate{

@IBOutlet weak var collectionView1: UICollectionView!
   
    var section1:Int!
    let section3Images=["purchase_entry.png"]
    let section3Titles=["Cash Payment"]
    let section0Titles=["Create Ledger","Create Item","Item Company Master","Dept Master","Sub-Dept master","Unit Master","Invoice TnC Master","Invoice Setting Master"]
    let section1Titles=["Purchase Entry","Purchase Edit","Sale Entry","Sale Edit","Purchase Return","Sale Return"]
    let section1Images=["purchase_entry.png","purchase_edit.png","credit_sale_entry.png","credit_sale_edit.png","purchase_return.png","sale_return.png"]
    let section0Images=[
    "create_ledger.png","create_item.png","company_master.png","dept_master.png","sub_dept_master.png","unit_master.png","terms_and_conditions.png","invoice_setting_master.png"]
    let section2Titles=["Purchase List","Sale List","Stock List","Party Ledger","GST R1","Sale Item Wise","Sale Company Wise","Sale Bill Wise"]
    let section2Images=["purchase_list.png","sale_list.png","stock_list.png","party_ledger.png","demo.png","item_wise.png","company_wise.png","bill_wise.png"]
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

 func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
 {
    
    let serverUrl=UserDefaults.standard.object(forKey: "server_url") as! String
    let db_name=UserDefaults.standard.object(forKey: "db_name") as! String
    let fnYear=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
    let dashBoardCompanyName=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
    //let urlForWebView=serverUrl+"Process/CashSale?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)"
  
    
    //http://wservice.khatabahi.online/Process/PartyLedger?DB=KhataBahiCommonBaseAndroid&CompanyName=Admin&FnYear=2017-2018
    
    
    //print(urlForWebView,"urlForWebViewbvsp")
    
   // print("\(indexPath)bvsp indexPathRo")
    let cell=collectionView1.cellForItem(at: indexPath) as! collectionView1Cell
    let labe=cell.label.text!
   
  switch (labe) {
    case "Create Item":
         let urlForWebView=serverUrl+"process/createItem?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)"
        UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
         let storyBoard=UIStoryboard(name: "Main", bundle: nil)
         let vc=storyBoard.instantiateViewController(withIdentifier: "webView")
         UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    

    case "Sale Entry":
        let urlForWebView=serverUrl+"Process/CashSale?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)"
     
        UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
        let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "webView")
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    
  case "Create Ledger":
    let urlForWebView=serverUrl+"process/createLedger?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)"
    UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
    
    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
    let vc=storyBoard.instantiateViewController(withIdentifier: "webView")
    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    
  case "Sale Edit":
    let urlForWebView=serverUrl+"Process/CreditSaleEdit?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)"
    UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
  case "Party Ledger":
    let urlForWebView=serverUrl+"Process/PartyLedger?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)"
    UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
    let vc=storyBoard.instantiateViewController(withIdentifier: "webView")
    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
  case "Purchase Edit":
    let urlForWebView=serverUrl+"Process/PurchaseEdit?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)"
    UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
    let vc=storyBoard.instantiateViewController(withIdentifier: "webView")
    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    
  case "Stock List":
    let urlForWebView=serverUrl+"Process/StockDetail?"+"DB=\(db_name)&CompanyName=\(dashBoardCompanyName)&FnYear=\(fnYear)"
    UserDefaults.standard.set(urlForWebView, forKey: "urlForWebView")
    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
    let vc=storyBoard.instantiateViewController(withIdentifier: "webView")
    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
  case "Item Company Master":
    
    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
    let vc=storyBoard.instantiateViewController(withIdentifier: "itemCompanyMaster")
    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
  case "Dept Master":
    
    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
    let vc=storyBoard.instantiateViewController(withIdentifier: "dept")
    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
  case "Sub-Dept master":
    
    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
    let vc=storyBoard.instantiateViewController(withIdentifier: "subDept")
    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
  case "Unit Master":
    
    let storyBoard=UIStoryboard(name: "Main", bundle: nil)
    let vc=storyBoard.instantiateViewController(withIdentifier: "unitMaster")
    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
    default:
        print("bvspRock")
    }
    
   /* let storyBoard=UIStoryboard(name: "Main", bundle: nil)
        let vc=storyBoard.instantiateViewController(withIdentifier: "webView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)*/
        //self.window?.rootViewController?.presentedViewController?.presentedViewController?.present(vc, animated: true, completion: nil)

   
    
   
   

    }
    

}
extension tableView1Cell : UICollectionViewDataSource {
    
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      section1=UserDefaults.standard.object(forKey: "section") as! Int
       section1=section1+1
        UserDefaults.standard.set(section1, forKey: "section")
        print("SectionCalling\(section1)")
        switch (section1) {
        case 0:
           
            return section0Titles.count
        case 1:
           
            return section3Titles.count
        case 2:
            
            return section1Titles.count
      
        default:
            return section2Titles.count
        }
        
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
       
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionViewCell", for: indexPath) as! collectionView1Cell
       
        switch (section1) {
        case 0:
            cell.label.text=section0Titles[indexPath.row]
            cell.image1.image=UIImage(named:"\(section0Images[indexPath.row])")
           
        case 1:
            cell.label.text=section3Titles[indexPath.row]
            cell.image1.image=UIImage(named:"\(section3Images[indexPath.row])")
            
        case 2:
            cell.label.text=section1Titles[indexPath.row]
            cell.image1.image=UIImage(named:"\(section1Images[indexPath.row])")
    
            
        default:
            cell.label.text=section2Titles[indexPath.row]
            cell.image1.image=UIImage(named:"\(section2Images[indexPath.row])")
            
        }
        //cell.label.text=section0Titles[indexPath.row]
        //cell.image1.image=UIImage(named:"\(section0Images[indexPath.row])")
       /* DispatchQueue.global().async {
            let imagelink=self.imagesLinks[indexPath.row]
            let imageurl=URL(string: "\(imagelink)")
            if imageurl != nil
            {
                let imageData = try? Data(contentsOf: imageurl!)
                
                DispatchQueue.main.async
                    {
                        
                        cell.image1.image=UIImage(data: imageData!)
                }
            }
        }
        cell.imageIcon.image=UIImage(named:"images.png")
        cell.imageIcon.layer.cornerRadius=15
        cell.imageIcon.layer.borderWidth=3
        cell.imageIcon.layer.borderColor=UIColor.yellow.cgColor*/
      
       
        
        return cell
    }
   
}
extension UIApplication
{
    class func topViewController(base:UIViewController?=UIApplication.shared
        .keyWindow?.rootViewController)->UIViewController?{
        if let nav=base as? UINavigationController{
            return topViewController(base:nav.visibleViewController)
        }
        if let tab=base as? UITabBarController{
            if let selected = tab.selectedViewController{
                return topViewController(base:selected)
            }
        }
        if let presented=base?.presentedViewController{
            return topViewController(base:presented)
        }
    
    return base
    }
  
}
