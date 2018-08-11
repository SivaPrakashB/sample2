//
//  T&CViewController.swift
//  KhataBahi
//
//  Created by Narayan on 4/28/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class T_CViewController: UIViewController,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate {
    
    
    @IBOutlet weak var selctTypeText: UITextField!
    var selection:Int=0
    var TraType="Purchase Invoice"
    var tableList=["Purchase Invoice","Sales Invoice"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView123.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text=tableList[indexPath.row]
        return cell!
        
    }
    
    var dashBoardElementValueForFn=String()
    var companyNameText=String()
    var db_name=String()
    var serverUrl=String()
    
    
    var imageView:UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
       
        
        /////barChartSetup
       
        serverUrl=UserDefaults.standard.object(forKey: "server_url") as! String
        
        dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        fnYear1234.text="(\(dashBoardElementValueForFn))"
        /////barChartSetup
        
        
        companyNameText=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        companyName1234.text=companyNameText
        a.delegate=self
        b.delegate=self
        c.delegate=self
        d.delegate=self
        e.delegate=self
        f.delegate=self
        tableView123.isHidden=true
        tableView123.separatorStyle = .none
        getTandC()
        
       
    }

    @IBOutlet weak var companyName1234: UILabel!
    
    @IBOutlet weak var fnYear1234: UILabel!
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showtableView(_ sender: UIButton) {
        tableView123.isHidden=false
        tableView123.delegate=self
        tableView123.dataSource=self
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selctTypeText.text=tableList[indexPath.row]
        
        tableView123.isHidden=true
        TraType=self.selctTypeText.text!
        getTandC()
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
    }
    
    @IBOutlet weak var tableView123: UITableView!
    
    
    
    @IBOutlet weak var a: UITextField!
    
    @IBOutlet weak var d: UITextField!
    
    @IBOutlet weak var c: UITextField!
    
    @IBOutlet weak var b: UITextField!
    
    @IBOutlet weak var f: UITextField!
    
    @IBOutlet weak var e: UITextField!
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        a.resignFirstResponder()
        b.resignFirstResponder()
        c.resignFirstResponder()
        d.resignFirstResponder()
        e.resignFirstResponder()
        f.resignFirstResponder()
        
        return true
    }
    
    @IBAction func save(_ sender: UIButton) {
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        
        saveTandC()
    }
    
    
    func saveTandC(){
        var terms1:String=self.a.text!
         var terms2:String=self.b.text!
         var terms3:String=self.c.text!
         var terms4:String=self.d.text!
         var terms5:String=self.e.text!
         var Desclaimer:String=self.f.text!
        TraType=self.selctTypeText.text!
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SaveTermandCondition xmlns=\"http://tempuri.org/\"><TraType>\(TraType)</TraType><terms1>\(terms1)</terms1><terms2>\(terms2)</terms2><terms3>\(terms3)</terms3><terms4>\(terms4)</terms4><terms5>\(terms5)</terms5><Desclaimer>\(Desclaimer)</Desclaimer><CompanyName>\(companyNameText)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></SaveTermandCondition></soap:Body></soap:Envelope>"
        let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        
        
        //let err: NSError?
        
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverUrl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/SaveTermandCondition", forHTTPHeaderField: "SOAPAction")
        
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
        if elementName == "GetTermandConditionResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "SaveTermandConditionResult" {
            elementValue = String()
            selection=1
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil && selection == 0 {
            elementValue! = string
           
       var TandCList=elementValue?.components(separatedBy: "^")
            if TandCList?.count == 6
            {DispatchQueue.main.async {
               
                self.a.text=TandCList![0]
                self.b.text=TandCList![1]
                self.c.text=TandCList![2]
                
                self.d.text=TandCList![3]
                self.e.text=TandCList![4]
                self.f.text=TandCList![5]
                }
            }
            DispatchQueue.main.async {
self.imageView.isHidden=true            }
            
            
        }
        if elementValue != nil && selection == 1
            {
                elementValue! = string
                print(elementValue)
                DispatchQueue.main.async {
                    self.imageView.isHidden=true            }
                DispatchQueue.main.async {
                    if self.elementValue! == "1"
                    { var oKaction:Int=5
                        UserDefaults.standard.set(oKaction, forKey: "oKaction")
                        var messageDescription="""
Terms and Conditions are
Saved successfully.....
"""
                        UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                        self.present(vc, animated: true, completion: nil)
                        
                    }
                    else
                    {
                        var oKaction:Int=5
                        UserDefaults.standard.set(oKaction, forKey: "oKaction")
                        var messageDescription="""
Terms and Conditions are
not Saved! Please try
Again later.........
"""
                        UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                    
                }
                
                
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetTermandConditionResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "SaveTermandConditionResult" {
            elementValue = String()
            selection=1
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    func getTandC(){
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetTermandCondition xmlns=\"http://tempuri.org/\"><TraType>\(TraType)</TraType><CompanyName>\(companyNameText)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetTermandCondition></soap:Body></soap:Envelope>"
        let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        
        
        //let err: NSError?
        
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=serverUrl.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetTermandCondition", forHTTPHeaderField: "SOAPAction")
        
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
    
    
    
}
