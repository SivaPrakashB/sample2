//
//  saleListShowViewController.swift
//  KhataBahi
//
//  Created by Narayan on 4/21/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import AnimatableReload
class saleListShowViewController: UIViewController,XMLParserDelegate,UITableViewDelegate,UITableViewDataSource {
    var db_name=String()
    
    @IBOutlet weak var tableView12: UITableView!
    var abc12345=0
    var dashBoardElementValueForFn=String()
    var serverurl=String()
    var dashBoardCompanyName1=String()
    var a=1
    var b=15
    var reference=0
    var remaining=0
    var startDate=String()
    var cName=String()
    var endDate=String()
    var TraType=String()
    var pages=0
    var saleLists:[String]=[String]()
    var dateLists:[String]=[String]()
    var voucherLists:[String]=[String]()
    var companyNameLists:[String]=[String]()
    var amountLists:[String]=[String]()
    var pidLists:[String]=[String]()
    var animateUpAndDown:Int=0
    
    
    var imageView:UIImageView!
    @IBOutlet weak var fnYear: UILabel!
    @IBOutlet weak var companyName: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        
        
        
        PRE1.clipsToBounds=true
        PRE1.layer.borderWidth=0.5
        PRE1.layer.borderColor=UIColor.lightGray.cgColor
        
        
        
        
        NEXT1.clipsToBounds=true
        NEXT1.layer.borderWidth=0.5
        NEXT1.layer.borderColor=UIColor.lightGray.cgColor
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        
        /////barChartSetup
      tableView12.separatorStyle = .none
        serverurl=UserDefaults.standard.object(forKey: "server_url") as! String
        
        dashBoardCompanyName1=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        
        startDate=UserDefaults.standard.object(forKey: "startDate") as! String
        endDate=UserDefaults.standard.object(forKey: "endDate") as! String
        
        /////barChartSetup
        
        cName=UserDefaults.standard.object(forKey: "Cname") as! String
        
        TraType=UserDefaults.standard.object(forKey: "TraType") as! String
        
        
        
        
        
        companyName.text=dashBoardCompanyName1
        fnYear.text="(\(dashBoardElementValueForFn))"
        
        
        listViewShow()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
    @IBAction func next(_ sender: UIButton) {
       imageView.isHidden=false
        if pages != 0 && pages != b
        {
        var remaining=pages-b
            if remaining>15
            {
                a=a+15
                b=b+15
            }
            else
            {
                a=a+15
                b=remaining+b
            }
            saleLists=[]
            dateLists=[]
            voucherLists=[]
            companyNameLists=[]
            abc12345=0
            listViewShow()
        }
        else
        {imageView.isHidden=true
           
                var oKaction:Int=0
                UserDefaults.standard.set(oKaction, forKey: "oKaction")
                var messageDescription="""
No More Data Available
"""
                UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                self.present(vc, animated: true, completion: nil)
         
        }
        
        
    /*    if b != pages
        {
   if remaining<b
   {
    
    a=a+15
    b=remaining+b
        }
        else
   {
    a=a+15
    b=b+15
        }
        saleLists=[]
        dateLists=[]
        voucherLists=[]
        companyNameLists=[]
        abc12345=0
           listViewShow()
        }
        else
        {
            
        }*/
    }
    
    @IBAction func previous(_ sender: UIButton) {
        
        imageView.isHidden=false
        if pages != 0 && a != 1
        {if b>15
        {var pre=b
         var tmp=b%15
            a=a-15
            b=b-tmp
            if pre==b
            {b=b-15}
            
            
        }else
        {
           
           a=1
      
            
            }
            
            saleLists=[]
            dateLists=[]
            voucherLists=[]
            companyNameLists=[]
            abc12345=0
            listViewShow()

        }
        else
        {imageView.isHidden=true
            
                var oKaction:Int=0
                UserDefaults.standard.set(oKaction, forKey: "oKaction")
                var messageDescription="""
No More Previous Data Available
"""
                UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                self.present(vc, animated: true, completion: nil)
          
        }
        
        
        
    /*   if a == 15
       {}
        else
       {
        if pages>15
        {
            if b>15
            {a=a-15
                b=b-15
                
            }
            else
            {a=1
            
                
            }
        }
        else
        {
            a=1
            b=pages
        }
        
        saleLists=[]
        dateLists=[]
        voucherLists=[]
        companyNameLists=[]
        abc12345=0
        listViewShow()
        }
   */
    }
    @IBOutlet weak var NEXT1: UIButton!
    
    @IBOutlet weak var PRE1: UIButton!
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func listViewShow(){
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetSaleList xmlns=\"http://tempuri.org/\"><TraTyp>\(TraType)</TraTyp><start>\(a)</start><end>\(b)</end><FromDte>\(startDate)</FromDte><ToDte>\(endDate)</ToDte><CName>\(cName)</CName><CompanyName>\(dashBoardCompanyName1)</CompanyName><DB>\(db_name)</DB><FnYear>\(dashBoardElementValueForFn)</FnYear><SecurityKey>KBRE@#4321</SecurityKey></GetSaleList></soap:Body></soap:Envelope>"
        let is_URL: String = serverurl+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        
        
        //let err: NSError?
        
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverurl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetSaleList", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            if response != nil
            {
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(strData)")
            
            let XMLparser = XMLParser(data: data!)
            XMLparser.delegate = self
            XMLparser.parse()
            //XMLparser.shouldResolveExternalEntities = true
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
                
            }
            }
        })
        task.resume()
    }
    
    
    
    
    var elementValue: String?
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetSaleListResult" {
            elementValue = String()
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil {
              elementValue! += string
   
            if elementValue! != "0"
            {
            elementValue!.replacingOccurrences(of: " &", with: "And ")
             var dummyList:[String]=(elementValue?.components(separatedBy: "^"))!
           
                pages=Int(dummyList[0])!
          
         
          
            if abc12345==0
            {
            
            
                
            print(abc12345)
            abc12345=abc12345+1
           
            print(elementValue,"SaleList")
            
            var dummyList:[String]=(elementValue?.components(separatedBy: "^"))!
           
          
            for value in 1..<dummyList.count
            {var saleListsDummy=dummyList[value]
                var saleListDummySeparated:[String]=saleListsDummy.components(separatedBy: "~") as! [String]
                print(saleListDummySeparated,"******saleListDummySeparated*****")
                if saleListDummySeparated.count==5
                {
                
              dateLists.append(saleListDummySeparated[0])
                voucherLists.append(saleListDummySeparated[1])
                companyNameLists.append(saleListDummySeparated[2])
                amountLists.append(saleListDummySeparated[3])
                pidLists.append(saleListDummySeparated[4])
                }
                
            }
               
              
            }
            reload()
            }
      
        else
        {DispatchQueue.main.async {
            var oKaction:Int=4
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var message:String="KhataBahi IOS App"
            UserDefaults.standard.set(message, forKey: "message")
            var messageDescription="""
            Sale list not available
            Please try again later
            thank you.........
            """
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
           UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
            
            
            }
            
        }
        }
        
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetSaleListResult" {
            elementValue = String()
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateLists.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView12.dequeueReusableCell(withIdentifier: "cell") as! saleListViewShowTableViewCell
        cell.date.text=dateLists[indexPath.row]
        cell.voucherName.text=voucherLists[indexPath.row]
        cell.customerName.text=companyNameLists[indexPath.row]
        cell.Amount.text=amountLists[indexPath.row]
        return cell
    }
    func reload()
    {DispatchQueue.main.async {
print(self.dateLists.count)
        print(self.voucherLists.count)
        self.tableView12.dataSource=self
        self.tableView12.delegate=self
        if self.animateUpAndDown % 2 == 0
        {
            AnimatableReload.reload(tableView: self.tableView12, animationDirection: "left")
            self.animateUpAndDown=self.animateUpAndDown+1
        }else
        {
           AnimatableReload.reload(tableView: self.tableView12, animationDirection: "right")
            self.animateUpAndDown=self.animateUpAndDown+1
        }
       
        self.imageView.isHidden=true
        //self.tableView12.reloadData()
        }
        
    }
    override func viewDidDisappear(_ animated: Bool) {
        imageView.isHidden=true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var pid:String=pidLists[indexPath.row]
        
        UserDefaults.standard.set(pid, forKey: "pid")
        
        
        
        let st=UIStoryboard(name: "Main", bundle: nil)
        let vc=st.instantiateViewController(withIdentifier: "salelistWebView") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        
    }
}
