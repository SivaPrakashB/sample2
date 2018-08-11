//
//  logInViewController.swift
//  KhataBahi
//
//  Created by Narayan on 3/27/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
var lastYear:lastFinancialYear?
class logInViewController: UIViewController,UIGestureRecognizerDelegate,XMLParserDelegate,UITextFieldDelegate {
    var status:String!
    var count:String!
    var website:String!
    var emailid:String!
    var phone:String!
    var db_name:String!
    var server_url:String!
    var company_name:String!
    var company_names=[String]()
    var selection:Int!
    var checkBoxCondition:Bool=false
    var activityIndicator:UIActivityIndicatorView=UIActivityIndicatorView()
    var imageView:UIImageView!
    var financialYearCalling:Int=0
    @IBOutlet weak var userName: UITextField!
    var expired:Int=0
    
    @IBOutlet weak var checkBox: UIButton!
    @IBOutlet weak var password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork() == false {
            print("Internet connection FAILED")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        UserDefaults.standard.set(nil, forKey: "fnlist")
        var any1:String!
      
        if  UserDefaults.standard.object(forKey:"loginUsername") != nil && UserDefaults.standard.object(forKey: "logoutStatus") == nil
      {  var username:String=UserDefaults.standard.object(forKey:"loginUsername") as! String
         var password3:String=UserDefaults.standard.object(forKey:"loginPassword") as! String
        userName.text = username
        password.text = password3
        checkBox.setBackgroundImage(UIImage(named:"check20.png"), for: .normal)
        checkBoxCondition=true
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        
       /* var width=(self.view.bounds.width/2)-40
        var height=(self.view.bounds.height/2)-40
        activityIndicator.frame=CGRect(x:width, y: height, width: 80, height: 80)
        activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.backgroundColor=UIColor.darkGray
        self.view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped=true*/
        loginAutomatic()
        }
        else if  UserDefaults.standard.object(forKey:"loginUsername") != nil{
            var username:String=UserDefaults.standard.object(forKey:"loginUsername") as! String
            var password3:String=UserDefaults.standard.object(forKey:"loginPassword") as! String
            userName.text = username
            password.text = password3
            checkBox.setBackgroundImage(UIImage(named:"check20.png"), for: .normal)
            checkBoxCondition=true
        }
        
        
        
        userName.delegate=self
        password.delegate=self
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(logInViewController.handleTap(_:)))
        tapGR.delegate = self
        tapGR.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGR)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func checkBoxAction(_ sender: UIButton) {
        if checkBoxCondition == false
        {
            checkBox.setBackgroundImage(UIImage(named:"check20.png"), for: .normal)
            checkBoxCondition=true
        }
        else{
            checkBox.setBackgroundImage(UIImage(named:"unchecked20.png"), for: .normal)
            checkBoxCondition=false
        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        
        view.endEditing(true)
        
    }
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.checkUpdate123()
            
        }
        
    }
    func checkUpdate123()
    {
        var a=0
        var version=2.0
        var updatedVersion123=UserDefaults.standard.object(forKey: "updatedVersion")
        print(updatedVersion123,"bvspupadetedversdiomn")
        var updatedVersion:String!
        while UserDefaults.standard.object(forKey: "UpdatedVersion") != nil && a==0 {
            a=1
            updatedVersion=UserDefaults.standard.object(forKey: "UpdatedVersion") as! String
            if version < Double("\(updatedVersion!)")!
            {
                DispatchQueue.main.async {
                    var oKaction:Int=3
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var message:String="KhataBahi IOS App"
                    UserDefaults.standard.set(message, forKey: "message")
                    var messageDescription="""
                    Updated Version of KhataBahi
                    Mobile Application \(updatedVersion!) is Now
                    Available
                    """
                    UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                    
                    
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                    self.present(vc, animated: true, completion: nil)
                    
                    
                }
            }
        }
        
        
    }
    func loginAutomatic()
    {if Reachability.isConnectedToNetwork() == false {
        print("Internet connection FAILED")
        let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
        alert.show()
        }
        else
    {
        var username123:String=UserDefaults.standard.object(forKey:"loginUsername") as! String
        var password3:String=UserDefaults.standard.object(forKey:"loginPassword") as! String
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UserLogin xmlns=\"http://tempuri.org/\"><UserId>\(username123)</UserId><Password>\(password3)</Password><SecurityKey>KBRE@#4321^IOS</SecurityKey></UserLogin></soap:Body></soap:Envelope>"
        
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
        lobj_Request.addValue("http://tempuri.org/UserLogin", forHTTPHeaderField: "SOAPAction")
        
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
            print("Response: \(response)")
            if data != nil
            {
            let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("Body: \(strData)")
            
            let XMLparser = XMLParser(data: data!)
            XMLparser.delegate = self
            XMLparser.parse()
            }
            //XMLparser.shouldResolveExternalEntities = true
            if error != nil 
            {
                print("Error: " + error!.localizedDescription)
                DispatchQueue.main.async {
                    self.imageView.isHidden=true
                }
            }
         
        })
        task.resume()
        }
    }
   /* override func viewDidDisappear(_ animated: Bool) {
        DispatchQueue.main.async {
            self.imageView.isHidden=true
        }
    }*/
    @IBAction func SignIn(_ sender: UIButton) {
        if Reachability.isConnectedToNetwork() == false {
            print("Internet connection FAILED")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        else
        {
        let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
        UserDefaults.standard.set(nil, forKey: "logoutStatus")
        
        var userNameValue=self.userName.text
        var passwordValue=self.password.text
         UserDefaults.standard.set(userNameValue!, forKey: "loginUsername123")
        if checkBoxCondition == true
        {
            UserDefaults.standard.set(userNameValue!, forKey: "loginUsername")
            UserDefaults.standard.set(passwordValue!, forKey: "loginPassword")
        }
        else{
            UserDefaults.standard.set(nil, forKey: "loginUsername")
            UserDefaults.standard.set(nil, forKey: "loginPassword")
        }
        
      
        
        if (userNameValue?.isEmpty)! || (passwordValue?.isEmpty)!
        {DispatchQueue.main.async {
            self.imageView.isHidden=true
            }
            var oKaction:Int=0
            UserDefaults.standard.set(oKaction, forKey: "oKaction")
            var messageDescription="""
Incorrect Credentials!
Please try again....
"""
            UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
            self.present(vc, animated: true, completion: nil)
            
        }
        else
        {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UserLogin xmlns=\"http://tempuri.org/\"><UserId>\(userNameValue!)</UserId><Password>\(passwordValue!)</Password><SecurityKey>KBRE@#4321^IOS</SecurityKey></UserLogin></soap:Body></soap:Envelope>"
            
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
            lobj_Request.addValue("http://tempuri.org/UserLogin", forHTTPHeaderField: "SOAPAction")
            
            let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
                if data != nil
                {
                print("Response: \(response)")
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(strData)")
                
                let XMLparser = XMLParser(data: data!)
                XMLparser.delegate = self
                XMLparser.parse()
                }
                //XMLparser.shouldResolveExternalEntities = true
                if error != nil
                {
                    print("Error: " + error!.localizedDescription)
                }
                
            })
            task.resume()
        }
        }
    }
    var elementValue: String?
    var elementValueForFn:String?
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "UserLoginResult" {
            elementValue = String()
            selection=1
            
        }
        if elementName == "GetFnYearResult"
        {
            elementValueForFn=String()
            selection = 2        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        DispatchQueue.main.async {
            self.imageView.isHidden=true
        }
        if elementValue != nil && selection! == 1{
            elementValue! += string
            if elementValue! == "0"
            {
                DispatchQueue.main.async {
                var oKaction:Int=0
                UserDefaults.standard.set(oKaction, forKey: "oKaction")
                var messageDescription="""
Incorrect Credentials!
Please try again....
"""
                UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                self.present(vc, animated: true, completion: nil)
                }
            }
            else if elementValue! == "2"
            {DispatchQueue.main.async {
                var messageDescription="""
Incorrect Security Key
Please Check Security Key....
"""
                UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                self.present(vc, animated: true, completion: nil)
                }
            }
            else{
                var ElementStringArray:[String]=elementValue!.components(separatedBy: "~")
                print(ElementStringArray,"bvsp Array")
                var  dummy:[String]=ElementStringArray[0].components(separatedBy: "@")
                db_name=dummy[0]
                print(db_name)
                UserDefaults.standard.set(db_name, forKey: "db_name")
                server_url=dummy[1]
                print(server_url)
                UserDefaults.standard.set(server_url, forKey: "server_url")
                company_name=ElementStringArray[1]
                company_names=company_name.components(separatedBy: "^")
                UserDefaults.standard.set(company_names, forKey: "company_names")
                print(company_names)
                
                
                if ElementStringArray.count > 6
                {
                    status = ElementStringArray[2]
                    
                    count = ElementStringArray[3]
                    
                    website = ElementStringArray[4]
                    
                    emailid = ElementStringArray[5]
                    
                    phone = ElementStringArray[6]
                    
                }
                else if ElementStringArray.count > 5
                {
                    status = ElementStringArray[2]
                    website = ElementStringArray[3]
                    
                    emailid = ElementStringArray[4]
                    
                    phone = ElementStringArray[5]
                    
                }
                if status == "0"
                {
                    var message12:String="""
                    Hi,
                    We hope you had a great time
                    trying out KhataBahi Mobile App.
                    sadly, your free trail is expired.
                    
                    Your account has been
                    deactivated. But you can still keep
                    using it by upagrading your account.
                    
                    Kindly, Contact our Customer
                    Care Service and reactive your
                    Account:
                    
                    Website:\(website!)
                    Email ID:\(emailid!)
                    Mobile No:\(phone!)
                    """
                    expired=2
                    UserDefaults.standard.set(message12, forKey: "message12")
                    DispatchQueue.main.async {
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "largePopUp") as! UIViewController
                       UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    }
                    
                }
                else if status == "2"{
                    financialYearCalling=1
                    var message12:String="""
                    Hi,
                    We hope you had a great time
                    trying out KhataBahi Mobile App.
                    sadly, your free trail is going
                    to expire in \(count!) days.
                    
                    Your Account will be
                    deactivated.But you can still keep
                    using it by upagrading your account.
                    
                    Kindly, Contact our Customer
                    Care Service and reactive your
                    Account:
                    
                    Website:\(website!)
                    Email ID:\(emailid!)
                    Mobile No:\(phone!)
                    
                    
                    """
                    DispatchQueue.main.async {
                        UserDefaults.standard.set(self.company_name!, forKey: "dashBoardCompanyName")
                        UserDefaults.standard.set(message12, forKey: "message12")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "large2PopUp") as! UIViewController
                     UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    }
                    
                }
                if expired != 2
                {
                if company_names.count == 1
                {
                    gettitngFinancialYear()
                    
                }
                else{
                   
                    DispatchQueue.main.async {
                        
                  let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "multipleCompany") as! UIViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                }
                }
                
                
            }
        }
        if elementValueForFn != nil && selection! == 2
        {
            elementValueForFn! += string
            print(elementValueForFn,"bvsp fn")
            if financialYearCalling==1
            {
                var fnlist=elementValueForFn?.components(separatedBy: "^")
                if fnlist!.count>1
                {
                    var fn=fnlist![0]
                    UserDefaults.standard.set(fn, forKey: "dashBoardElementValueForFn")
                   
                    
                }
                else
                {
                    UserDefaults.standard.set(elementValueForFn!, forKey: "dashBoardElementValueForFn")
                   
                }
            }
            else
            {
                var fnlist=elementValueForFn?.components(separatedBy: "^")
                if fnlist!.count>1
                {
                    var fn=fnlist![0]
                    UserDefaults.standard.set(fn, forKey: "dashBoardElementValueForFn")
                    UserDefaults.standard.set(fnlist!, forKey: "fnlist")
                      UserDefaults.standard.set(self.company_name!, forKey: "dashBoardCompanyName")
                    DispatchQueue.main.async {
                      
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "dashBoard")
                        // self.present(vc, animated: true, completion: nil)
                        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                    }
                    
                }
                else
                {
                    
                    UserDefaults.standard.set(elementValueForFn!, forKey: "dashBoardElementValueForFn")
                     UserDefaults.standard.set(self.company_name!, forKey: "dashBoardCompanyName")
                    DispatchQueue.main.async {
                       
                        
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "dashBoard")
                        // self.present(vc, animated: true, completion: nil)
                        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
                        
                }
            }
            }
            
        }
      
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "UserLoginResult" {
            elementValue = String()
        }
        if elementName == "GetFnYearResult"
        {
            elementValueForFn=String()
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    func gettitngFinancialYear()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetFnYear xmlns=\"http://tempuri.org/\"><CompanyName>\(company_name!)</CompanyName><DB>\(db_name!)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetFnYear></soap:Body></soap:Envelope>"
        
        print(is_SoapMessage)
        
        let is_URL: String = server_url+"WSKhataBahiOnline.asmx"
        ///Host Url///
        var hosturlList=server_url.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        
        ////http://wservice.khatabahi.online/ /////////
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetFnYear", forHTTPHeaderField: "SOAPAction")
        
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
   
}
