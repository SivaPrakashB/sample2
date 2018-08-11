//
//  contactUSViewController.swift
//  KhataBahi
//
//  Created by Narayan on 5/10/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class contactUSViewController: UIViewController,UITextFieldDelegate,XMLParserDelegate {
    var dashBoardElementValueForFn=String()
    var db_name=String()
    var serverUrl=String()
    var companyNameText1=String()
    var companyDetailsResults=String()
    var selection=0
    var imageView143=UIImageView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView143 = UIImageView(image: jeremyGif)
        
        imageView143.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView143)
        self.view.isUserInteractionEnabled=false
        
        companyNameText.delegate=self
        emailID.delegate=self
        mobileNUmber.delegate=self
        feedBack.delegate=self
        dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        fnyearLabel.text="(\(dashBoardElementValueForFn))"
        /////barChartSetup
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        serverUrl=UserDefaults.standard.object(forKey: "server_url") as! String
        companyNameText1=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        dashboardCompanyTitle.text=companyNameText1
        companyNameText.text=companyNameText1
        // Do any additional setup after loading the view.
        getCompanyDetails()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBOutlet weak var fnyearLabel: UILabel!
    
    @IBOutlet weak var dashboardCompanyTitle: UILabel!
    @IBOutlet weak var companyNameText: UITextField!
    
    @IBOutlet weak var emailID: UITextField!
    
    @IBOutlet weak var mobileNUmber: UITextField!
    
    @IBOutlet weak var feedBack: UITextField!
    
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        companyNameText.resignFirstResponder()
        emailID.resignFirstResponder()
        mobileNUmber.resignFirstResponder()
        feedBack.resignFirstResponder()
        return true
    }
    func getCompanyDetails(){
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetCompanyDetailsForFeedBack xmlns=\"http://tempuri.org/\"><CompanyName>\(companyNameText1)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetCompanyDetailsForFeedBack></soap:Body></soap:Envelope>"
        let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        
        
        
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
        lobj_Request.addValue("http://tempuri.org/GetCompanyDetailsForFeedBack", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            //print("Response: \(response)")
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
                DispatchQueue.main.async {
                    self.imageView143.isHidden=true
                    self.view.isUserInteractionEnabled=true
                    var dummyList=self.companyDetailsResults.components(separatedBy: "^")
                    if dummyList.count==2
                    {
                        self.emailID.text=dummyList[1]
                     if dummyList[1].characters.count>2
                        {
                            self.emailID.isUserInteractionEnabled=false
                        }
                     else
                     {
                        self.emailID.isUserInteractionEnabled=true
                        }
                       
                        self.mobileNUmber.text=dummyList[0]
                    }
                   
                    
                }
                
            }
        })
        task.resume()
    }
    func submitContactUS()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><SubmitContactUs xmlns=\"http://tempuri.org/\"><Name>\(companyNameText1)</Name><email>\(emailID.text!)</email><mono>\(mobileNUmber.text!)</mono><msg>\(feedBack.text!)</msg><SecurityKey>#111000$</SecurityKey></SubmitContactUs></soap:Body></soap:Envelope>"
        let is_URL: String = "http://admin.khatabahi.com/KhataBahiService.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("admin.khatabahi.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/SubmitContactUs", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            
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
            DispatchQueue.main.async {
                self.feedBack.text=""
                print(self.feedBackResults,"bvsp ***********")
                self.imageView143.isHidden=true
                self.view.isUserInteractionEnabled=true
                if self.feedBackResults=="0"
                {
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
Your Message not Sent
Successfully!
Please try Again Later......
"""
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
                else if self.feedBackResults=="1"
                {
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
Your Message has been sent
Successfully!
Khata Bahi Contact will to you soon........
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
                    \(self.feedBackResults)
                    """
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
            }
        })
        
        task.resume()
        
    }
    
    var elementValue: String?
    var updateFeedBack:String?
    var feedBackResults=String()
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetCompanyDetailsForFeedBackResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "SubmitContactUsResult" {
            updateFeedBack = String()
            selection=1
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil && selection == 0{
            elementValue! += string
            
            companyDetailsResults=elementValue!
            
        }
        if updateFeedBack != nil && selection == 1{
            updateFeedBack! += string
            
            feedBackResults=updateFeedBack!
            
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetCompanyDetailsForFeedBackResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "SubmitContactUsResult" {
            updateFeedBack = String()
            selection=1
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    @IBAction func submit(_ sender: UIButton) {
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView143 = UIImageView(image: jeremyGif)
        
        imageView143.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView143)
        self.view.isUserInteractionEnabled=false
        let valid = validateEmail(candidate: self.emailID.text! as String)
        if self.companyNameText.text!.isEmpty==true
        {imageView143.isHidden=true
            self.view.isUserInteractionEnabled=true
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Enter Company name
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
        else if self.emailID.text!.isEmpty == true
        {imageView143.isHidden=true
            self.view.isUserInteractionEnabled=true
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Enter Email ID
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
        else if valid != true
        {imageView143.isHidden=true
            self.view.isUserInteractionEnabled=true
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Enter Valid Email ID
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
        else if self.mobileNUmber.text!.isEmpty==true
        {imageView143.isHidden=true
            self.view.isUserInteractionEnabled=true
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Enter The Mobile Number
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
        else if self.feedBack.text!.isEmpty==true
        {imageView143.isHidden=true
            self.view.isUserInteractionEnabled=true
            var oKaction:Int=5
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Enter The Message
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
        }
        else
        {
            submitContactUS()
        }
        
        
        
        
    }
    
    func validateEmail(candidate: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: candidate)
    }
    
    
    
}
