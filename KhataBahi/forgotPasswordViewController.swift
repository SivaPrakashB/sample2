//
//  forgotPasswordViewController.swift
//  KhataBahi
//
//  Created by Narayan on 4/9/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class forgotPasswordViewController: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate,XMLParserDelegate {
    var serverUrl:String=String()
    var selection:Int!
     var activityIndicator:UIActivityIndicatorView=UIActivityIndicatorView()
    @IBOutlet weak var userId: UITextField!
    @IBOutlet weak var topView: UIView!
   
   // let colorOf=UIColor(displayP3Red: 116, green: 163, blue: 203, alpha: 1)//(red: 116, green: 163, blue: 209, alpha: 1)
    override func viewDidLoad() {
        super.viewDidLoad()
        var width=(self.view.bounds.width/2)-40
        var height=(self.view.bounds.height/2)-40
        activityIndicator.frame=CGRect(x:width, y: height, width: 80, height: 80)
        activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.backgroundColor=UIColor.darkGray
        self.view.addSubview(activityIndicator)
       
        activityIndicator.hidesWhenStopped=true
       topView.layer.cornerRadius=10
        topView.layer.borderWidth=7
        topView.layer.borderColor=UIColor.clear.cgColor
     userId.layer.cornerRadius=8
    userId.layer.borderWidth=2
        
        userId.layer.borderColor=UIColor.blue.cgColor
       
        let myColor : UIColor = UIColor( red: 116/225, green: 163/255, blue:209/225, alpha: 1.0 )
        userId.layer.masksToBounds = true
        userId.layer.borderColor = myColor.cgColor
       
        let tapGR = UITapGestureRecognizer(target: self, action: #selector(forgotPasswordViewController.handleTap(_:)))
        tapGR.delegate = self
        tapGR.numberOfTapsRequired = 1
        view.addGestureRecognizer(tapGR)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        userId.resignFirstResponder()
        return true
    }
    @objc func handleTap(_ gesture: UITapGestureRecognizer){
        
        view.endEditing(true)
        
    }
    
    
    @IBAction func contactUs(_ sender: UIButton) {
        
        
        let sUrl = "googlechrome://www.khatabahi.com"
        UIApplication.shared.openURL(NSURL(string: sUrl) as! URL)
        
        
    }
    
    @IBAction func send(_ sender: UIButton) {
        userId.resignFirstResponder()
        activityIndicator.startAnimating()
        var userId1:String=self.userId.text as! String
        if userId1 != nil
        {
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetServerURL xmlns=\"http://tempuri.org/\"><UserID>\(userId1)</UserID><SecurityKey>KBRE@#4321</SecurityKey></GetServerURL></soap:Body></soap:Envelope>"
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
        lobj_Request.addValue("http://tempuri.org/GetServerURL", forHTTPHeaderField: "SOAPAction")
        
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
    var elementValue: String?
    var forgotResponse:String=String()
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetServerURLResult" {
            elementValue = String()
            selection = 0
            
        }
        if elementName == "GetForgotPasswordResult" {
            forgotResponse = String()
            selection = 1
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
     
        if elementValue != nil && selection! == 0{
            DispatchQueue.main.async {
                 self.activityIndicator.stopAnimating()
            }
           
            elementValue! += string
            print(elementValue,"bvspelement")
            if elementValue! == "0"
            {DispatchQueue.main.async {
                var oKaction:Int=0
                UserDefaults.standard.set(oKaction, forKey: "oKaction")
                var messageDescription="""
Your user ID not registered in database!
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
                serverUrl=elementValue!
              getForgotPassword()
                
            }
        
            
            
        }
        
     if forgotResponse != nil && selection! == 1
        {
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
            }
            forgotResponse += string
            if forgotResponse == "1"
            {DispatchQueue.main.async {
                var oKaction:Int=0
                UserDefaults.standard.set(oKaction, forKey: "oKaction")
                var messageDescription="""
Your reset password link has been sent to your registered email address ("\(self.userId.text!)") successfully! Thank You..
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
        if elementName == "GetServerURLResult" {
            elementValue = String()
        }
        if elementName == "GetForgotPasswordResult" {
            forgotResponse = String()
          
            
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    
    
    
    
    
    
    
    
    func getForgotPassword()
    { var userId1:String=self.userId.text as! String
        if userId1 != nil
        {
            var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetForgotPassword xmlns=\"http://tempuri.org/\"><UserID>\(userId1)</UserID><SecurityKey>KBRE@#4321</SecurityKey></GetForgotPassword></soap:Body></soap:Envelope>"
            let is_URL: String = "\(serverUrl)WSKhataBahiOnline.asmx"
            print("\(is_URL)bvspUrl123")
            
            let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
            let session = URLSession.shared
            //let err: NSError?
            
            lobj_Request.httpMethod = "POST"
            lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
            var hosturlList=serverUrl.components(separatedBy: "//")
            var hosturlList1=hosturlList[1]
            var hosturlList2=hosturlList1.components(separatedBy: "/")
            var hosturlFinal:String=hosturlList2[0]
            print("\(hosturlFinal)bvspHostfinal")
            lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
            lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
            lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
            lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
            lobj_Request.addValue("http://tempuri.org/GetForgotPassword", forHTTPHeaderField: "SOAPAction")
            
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
    
}
