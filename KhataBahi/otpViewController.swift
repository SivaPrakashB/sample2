//
//  otpViewController.swift
//  KhataBahi
//
//  Created by Narayan on 5/7/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class otpViewController: UIViewController,UITextFieldDelegate,XMLParserDelegate {
var mobileNumberForOTP=String()
    var imageView1:UIImageView!
    var selection=0
    var globalValues=String()
    var globalCompanyName=String()
    var globalLandLineNumber=String()
    var globalPostalAddress=String()
    var globalCountryName=String()
    var globalStateName=String()
    var globalCityname=String()
    var globalEmailId=String()
    var globalMobileNumber=String()
    var globalSetPassword=String()
    var status=String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    enterOtp.delegate=self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    override func viewDidAppear(_ animated: Bool) {
         mobileNumberForOTP=UserDefaults.standard.object(forKey: "mobileNumberForOTP") as! String
        globalValues=UserDefaults.standard.object(forKey: "globalValues") as! String
        var dummyValues=globalValues.components(separatedBy: "^")
        globalCompanyName=dummyValues[0]
        globalLandLineNumber=dummyValues[1]
        globalPostalAddress=dummyValues[2]
        globalCountryName=dummyValues[3]
        globalStateName=dummyValues[4]
        globalCityname=dummyValues[5]
        globalEmailId=dummyValues[6]
        globalMobileNumber=dummyValues[7]
        globalSetPassword=dummyValues[8]
    }

  
    
    @IBOutlet weak var enterOtp: UITextField!
    
    
    
    @IBAction func okAction(_ sender: UIButton) {
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView1 = UIImageView(image: jeremyGif)
        
        imageView1.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView1)
        
        verifyOTP()
    }
    
    @IBOutlet weak var regenerateOTP: UIButton!
    
    @IBAction func regenarateOTPAction(_ sender: UIButton) {
        
        
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView1 = UIImageView(image: jeremyGif)
        
        imageView1.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView1)
        
       generateOTP()
        
    }
    
    @IBAction func closeAction(_ sender: UIButton) {
        dismiss(animated: false, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        enterOtp.resignFirstResponder()
        
        
        
        return true
    }
    func abc()
    {
        let alert=UIAlertController(title: "Alert", message: "abc", preferredStyle: .alert)
        let  ACTION1=UIAlertAction(title: "Ok", style: .cancel, handler:
            {ACTION in
             let st=UIStoryboard(name: "Main", bundle: nil)
                let vc=st.instantiateViewController(withIdentifier: "abc") as! UIViewController
                UIApplication.topViewController()?.present(vc, animated: false, completion: nil)
                    
          
        })
        alert.addAction(ACTION1)
        self.present(alert, animated: true, completion: nil)
        
    }
    func verifyOTP()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><VeryfyOTP xmlns=\"http://tempuri.org/\"><Mobile>\(mobileNumberForOTP)</Mobile><OTP>\(enterOtp.text!)</OTP><SecurityKey>KBRE@#4321</SecurityKey></VeryfyOTP></soap:Body></soap:Envelope>"
        
        print(is_SoapMessage)
        
        let is_URL: String = "http://wservice.khatabahi.online/WSKhataBahiOnline.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("wservice.khatabahi.online", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/VeryfyOTP", forHTTPHeaderField: "SOAPAction")
        
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
            
        })
        task.resume()
    }
    func generateOTP()
    {
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GenerateOTP xmlns=\"http://tempuri.org/\"><Mobile>\(mobileNumberForOTP)</Mobile><SecurityKey>KBRE@#4321</SecurityKey></GenerateOTP></soap:Body></soap:Envelope>"
        
        print(is_SoapMessage)
        
        let is_URL: String = "http://wservice.khatabahi.online/WSKhataBahiOnline.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("wservice.khatabahi.online", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GenerateOTP", forHTTPHeaderField: "SOAPAction")
        
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
            
        })
        task.resume()
    }
    
    
    
    
    
    
    
    
    var generateOTPvalue:String!
    var elementValue: String?
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "VeryfyOTPResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "GenerateOTPResult" {
            generateOTPvalue = String()
            selection=1
        }
        if elementName == "CreateNewCompanyResult"
        {
            status=String()
            selection = 2        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        var data=string.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        if elementValue != nil  && selection==0{
            elementValue! = string
           
            print(elementValue)
            
            
           
      /*  DispatchQueue.main.async {
             self.imageView1.isHidden=true
             }**/
            
            
            
            
            DispatchQueue.main.async {
                if self.elementValue! == "1"
                {
                    
                   // UserDefaults.standard.set(nil, forKey: "logoutStatus")
                   
                   self.createNewCompany()
                   
                    
                }
                else
                {
                    DispatchQueue.main.async {
                        self.imageView1.isHidden=true
                    }
                    
                    
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
                    Please Check OTP
                    """
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
            
            }
        }
        if generateOTPvalue != nil && selection == 1
        {
            generateOTPvalue=string
            
            DispatchQueue.main.async {
                self.imageView1.isHidden=true
            }
            
            
            
            
            DispatchQueue.main.async {
                if self.generateOTPvalue! == "1"
                {
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
                    Your OTP has been sent to
                    \(self.mobileNumberForOTP)Please check...
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
                    \(self.generateOTPvalue!)
                    """
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                }
            }
            
        }
        if (!data.isEmpty) && selection==2{
            
            status=string
            print(status,"BVSP ROCK *************************")
            
            
            DispatchQueue.main.async {
                self.imageView1.isHidden=true
            }
            
            DispatchQueue.main.async {
                if self.status == "1"
                {
                    UserDefaults.standard.set(self.globalEmailId, forKey: "loginUsername")
                    UserDefaults.standard.set(self.globalSetPassword, forKey: "loginPassword")
                  UserDefaults.standard.set(nil, forKey: "logoutStatus")
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "login") as! UIViewController
                    UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    /* var oKaction:Int=7
                     UserDefaults.standard.set(oKaction, forKey: "oKaction")
                     var messageDescription="""
                     Your are Succcessfully
                     Completed Sign Up!
                     Welcome To Khata Bahi! .....
                     """
                     UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                     let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                     self.present(vc, animated: true, completion: nil)
                     
                     */
                    /*let storyboard = UIStoryboard(name: "Main", bundle: nil)
                     let vc = storyboard.instantiateViewController(withIdentifier: "login") as! UIViewController
                     UIApplication.topViewController()?.present(vc, animated: true, completion: nil)*/
                    
                    
                }
                else
                {
                    
                    
                    DispatchQueue.main.async {
                        self.imageView1.isHidden=true
                    }
                    
                    
                    
                    var oKaction:Int=5
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
                    \(self.status)
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
        if elementName == "VeryfyOTPResult" {
            elementValue = String()
            selection=0
        }
        if elementName == "GenerateOTPResult" {
            generateOTPvalue = String()
            selection=1
        }
        if elementName == "CreateNewCompanyResult"
        {
            status=String()
            selection = 2        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    func createNewCompany(){
       
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><CreateNewCompany xmlns=\"http://tempuri.org/\"><CompanyName>\(globalCompanyName)</CompanyName><TelephoneNo>\(globalLandLineNumber)</TelephoneNo><Address>\(globalPostalAddress)</Address><Country>\(globalCountryName)</Country><State>\(globalStateName)</State><City>\(globalCityname)</City><Email>\(globalEmailId)</Email><Mobile>\(globalMobileNumber)</Mobile><GSTIN></GSTIN><pass>\(globalSetPassword)</pass><Logo_str></Logo_str><SecurityKey>KBRE@#4321</SecurityKey></CreateNewCompany></soap:Body></soap:Envelope>"
        let is_URL: String = "http://wservice.khatabahi.online/WSKhataBahiOnline.asmx"
        print(is_SoapMessage)
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        
        
        //let err: NSError?
        
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        
        lobj_Request.addValue("wservice.khatabahi.online", forHTTPHeaderField: "Host")
        
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/CreateNewCompany", forHTTPHeaderField: "SOAPAction")
        
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
