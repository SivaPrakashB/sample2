//
//  unitMasterViewController.swift
//  KhataBahi
//
//  Created by Narayan on 4/10/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class unitMasterViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,XMLParserDelegate {
    var sampleList:[String]=["a","b"]
    var srNo=[String]()
    var createItemList=[String]()
    var saveAction=0
    var viewAction=0
    var dashBoardElementValueForFn=String()
    var db_name=String()
    var serverUrl=String()
    var companyNameText=String()
    var serialNo=String()
    var selection=0
    var imageView=UIImageView()
    
    @IBOutlet weak var companyName: UILabel!
    
    
    @IBOutlet weak var tableview1: UITableView!
    @IBOutlet weak var year: UILabel!
    
    @IBOutlet weak var createItemCompanyName: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        year.text="(\(dashBoardElementValueForFn))"
        /////barChartSetup
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        serverUrl=UserDefaults.standard.object(forKey: "server_url") as! String
        companyNameText=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        companyName.text=companyNameText
        modifyView.isHidden=true
        
        tableview1.separatorStyle = .none
        //tableview1.reloadData()
        createItemCompanyName.delegate=self
        getItemList()
    }
    
    
    
    @IBOutlet weak var modifyView: UIView!
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var viewActionButton: UIButton!
    @IBOutlet weak var saveButtonAction: UIButton!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return createItemList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell=tableview1.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text=createItemList[indexPath.row]
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        modifyView.isHidden=false
        createItemCompanyName.text=createItemList[indexPath.row]
        createItemCompanyName.isHidden=true
        serialNo=srNo[indexPath.row]
        
    }
    @IBAction func saveButton(_ sender: UIButton) {
        if saveAction == 0
        {
            if createItemCompanyName.text!.isEmpty==true
            {
                var oKaction:Int=5
                UserDefaults.standard.set(oKaction, forKey: "oKaction")
                var messageDescription="""
Enter Item Company Name!
"""
                UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                self.present(vc, animated: true, completion: nil)
            }
            else
            {let jeremyGif = UIImage.gifImageWithName("abc1234")
                imageView = UIImageView(image: jeremyGif)
                
                imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
                self.view.addSubview(imageView)
                
                createItemCompany()
                createItemCompanyName.text=""
            }
        }
        if saveAction==1
        {let jeremyGif = UIImage.gifImageWithName("abc1234")
            imageView = UIImageView(image: jeremyGif)
            
            imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
            self.view.addSubview(imageView)
            upDateItemCompany()
            saveButtonAction.setTitle("SAVE", for: .normal)
            saveAction=0
            viewActionButton.setTitle("VIEW/REFRESH", for: .normal)
            viewAction=0
            tableview1.isHidden=false
        }
    }
    
    @IBAction func viewRefresh(_ sender: UIButton) {
        if viewAction == 0
        {let jeremyGif = UIImage.gifImageWithName("abc1234")
            imageView = UIImageView(image: jeremyGif)
            
            imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
            self.view.addSubview(imageView)
            createItemList=[String]()
            getItemList()
            
            
        }
        else
        {createItemCompanyName.resignFirstResponder()
            createItemCompanyName.text=""
            saveButtonAction.setTitle("SAVE", for: .normal)
            saveAction=0
            viewActionButton.setTitle("VIEW/REFRESH", for: .normal)
            viewAction=0
            tableview1.isHidden=false
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: UIButton) {
        createItemCompanyName.isHidden=false
        createItemCompanyName.text=""
        modifyView.isHidden=true
    }
    
    @IBAction func modify(_ sender: UIButton) {
        
        tableview1.isHidden=true
        
        saveButtonAction.setTitle("UPDATE", for: .normal)
        saveAction=1
        viewActionButton.setTitle("CANCEL", for: .normal)
        viewAction=1
        
        createItemCompanyName.isHidden=false
        
        createItemCompanyName.becomeFirstResponder()
        modifyView.isHidden=true
        
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        createItemCompanyName.resignFirstResponder()
        return true
    }
    func getItemList(){
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetItemUnitList xmlns=\"http://tempuri.org/\"><CompanyName>\(companyNameText)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetItemUnitList></soap:Body></soap:Envelope>"
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
        lobj_Request.addValue("http://tempuri.org/GetItemUnitList", forHTTPHeaderField: "SOAPAction")
        
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
    
    func upDateItemCompany(){
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UpdateNewUnit xmlns=\"http://tempuri.org/\"><Sno>\(serialNo)</Sno><unit_name>\(createItemCompanyName.text!)</unit_name><CompanyName>\(companyNameText)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></UpdateNewUnit></soap:Body></soap:Envelope>"
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
        lobj_Request.addValue("http://tempuri.org/UpdateNewUnit", forHTTPHeaderField: "SOAPAction")
        
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
    func createItemCompany(){
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CreateNewUnit xmlns=\"http://tempuri.org/\"><unit_name>\(createItemCompanyName.text!)</unit_name><CompanyName>\(companyNameText)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></CreateNewUnit></soap:Body></soap:Envelope>"
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
        lobj_Request.addValue("http://tempuri.org/CreateNewUnit", forHTTPHeaderField: "SOAPAction")
        
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
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetItemUnitListResult"  {
            elementValue = String()
            selection=0
            
        }
        if elementName == "UpdateNewUnitResult" {
            elementValue = String()
            selection=1
            
        }
        if elementName == "CreateNewUnitResult" {
            elementValue = String()
            selection=2
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        DispatchQueue.main.async {
            self.imageView.isHidden=true
        }
        if elementValue != nil  && selection==0{
            elementValue! = string
            print(elementValue)
            var dummyList:[String]=(elementValue?.components(separatedBy: "^"))!
            for value in dummyList
            {var dummyvalue:[String]=value.components(separatedBy: "~")
                
                srNo.append(dummyvalue[0])
                createItemList.append(dummyvalue[1])
                
            }
            DispatchQueue.main.async {
                self.tableview1.reloadData()
            }
            
        }
        if elementValue != nil && selection == 1 {
            elementValue! = string
            print(elementValue)
            DispatchQueue.main.async {
                if self.elementValue! == "1"
                {
                    
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
New Unit  Name
Updated successfully.....
"""
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                    self.createItemList=[String]()
                    self.getItemList()
                     self.createItemCompanyName.text=""
                    
                }
                else
                {
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
New Unit Name
not Updated! Please try
Again later.........
"""
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
        if elementValue != nil && selection == 2 {
            elementValue! = string
            print(elementValue)
            DispatchQueue.main.async {
                if self.elementValue! == "1"
                {
                    
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
New Item Unit Name
Created successfully.....
"""
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                    self.createItemList=[String]()
                    self.getItemList()
                     self.createItemCompanyName.text=""
                    
                }
                else
                {
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
New Item Unit Name
not Created! Please try
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
        if elementName == "GetItemUnitListResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "UpdateNewUnitResult" {
            elementValue = String()
            selection=1
            
        }
        if elementName == "CreateNewUnitResult" {
            elementValue = String()
            selection=2
            
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
}
