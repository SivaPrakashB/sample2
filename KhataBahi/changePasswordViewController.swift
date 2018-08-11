    //
    //  changePasswordViewController.swift
    //  KhataBahi
    //
    //  Created by Narayan on 4/11/18.
    //  Copyright © 2018 senovTech. All rights reserved.
    //
    
    import UIKit
    
    class changePasswordViewController: UIViewController,UITextFieldDelegate,UIGestureRecognizerDelegate,XMLParserDelegate {
        
        
        
        
        @IBOutlet weak var v1: UIView!
        
        @IBOutlet weak var currentPassword: UITextField!
        
        @IBOutlet weak var v2text: UILabel!
        @IBOutlet weak var v1text: UILabel!
        @IBOutlet weak var newPassword: UITextField!
        
        @IBOutlet weak var v3: UIView!
        
        @IBOutlet weak var confirmNewPassword: UITextField!
        
        @IBOutlet weak var v3text: UILabel!
        
        @IBOutlet weak var v2: UIView!
        
        
        
        
        
        var username1:String=String()
        var serverUrl:String=String()
        var dbname:String=String()
        var companyName1:String=String()
        
        
        override func viewDidLoad() {
            super.viewDidLoad()
            username1=UserDefaults.standard.object(forKey:"loginUsername123") as! String
            serverUrl=UserDefaults.standard.object(forKey: "server_url") as! String
            dbname=UserDefaults.standard.object(forKey: "db_name") as! String
            companyName1=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
            currentPassword.delegate=self
            newPassword.delegate=self
            confirmNewPassword.delegate=self
            v1.isHidden=true
            v2.isHidden=true
            v3.isHidden=true
            let tapGR = UITapGestureRecognizer(target: self, action: #selector(changePasswordViewController.handleTap(_:)))
            tapGR.delegate = self
            tapGR.numberOfTapsRequired = 1
            view.addGestureRecognizer(tapGR)
            
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        @IBAction func dismiss1(_ sender: UIButton) {
            dismiss(animated: true, completion: nil)
        }
        func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            currentPassword.resignFirstResponder()
            newPassword.resignFirstResponder()
            confirmNewPassword.resignFirstResponder()
            return true
        }
        @objc func handleTap(_ gesture: UITapGestureRecognizer){
            
            view.endEditing(true)
            
        }
        
        
        @IBAction func update(_ sender: UIButton) {
            v1.isHidden=true
            v2.isHidden=true
            v3.isHidden=true
            if currentPassword.text?.isEmpty == true
            {
                v3.isHidden=false
                v3text.text="Enter current Password"
            }
            if newPassword.text?.isEmpty==true
            {
                v1.isHidden=false
                v1text.text="Enter new password"
            }
            if confirmNewPassword.text?.isEmpty==true
            {
                v2.isHidden=false
                v2text.text="enter confirm password"
            }
            if currentPassword.text?.isEmpty == false && newPassword.text?.isEmpty == false && confirmNewPassword.text?.isEmpty == false
            {
                if newPassword.text! != confirmNewPassword.text!
                {
                    DispatchQueue.main.async {
                        var oKaction:Int=0
                        UserDefaults.standard.set(oKaction, forKey: "oKaction")
                        var messageDescription="""
    new password and confirm password
    Not matched!
    Please try again....
    """
                        UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                        let storyboard = UIStoryboard(name: "Main", bundle: nil)
                        let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                        self.present(vc, animated: true, completion: nil)
                    }
                }
                else
                {
                    
                    
                    var oldpass:String=self.currentPassword.text!
                    var newpass:String=self.newPassword.text!
                    
                    var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetResetPassword xmlns=\"http://tempuri.org/\"><UserID>\(username1)</UserID><old_pass>\(oldpass)</old_pass><new_pass>\(newpass)</new_pass><CompanyName>\(companyName1)</CompanyName><DB>\(dbname)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetResetPassword></soap:Body></soap:Envelope>"
                    print(is_SoapMessage,"getGraphdataBvsp")
                    let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
                    
                    let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
                    let session = URLSession.shared
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
                    lobj_Request.addValue("http://tempuri.org/GetResetPassword", forHTTPHeaderField: "SOAPAction")
                    
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
    /*func abc123()
     {var oldpass:String=self.currentPassword.text
     var newpass:String=self.newPassword.text
     
     var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetResetPassword xmlns=\"http://tempuri.org/\"><UserID>\(username1)</UserID><old_pass>\(oldpass)</old_pass><new_pass>\(newpass)</new_pass><CompanyName>\(companyName1)</CompanyName><DB>\(dbname)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetResetPassword></soap:Body></soap:Envelope>"
     print(is_SoapMessage,"getGraphdataBvsp")
     let is_URL: String = serverUrl+"WSKhataBahiOnline.asmx"
     
     let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
     let session = URLSession.shared
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
     lobj_Request.addValue("http://tempuri.org/GetDataForGraph", forHTTPHeaderField: "SOAPAction")
     
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
     */
    
    
    
    var elementValue: String?
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetResetPasswordResult" {
            elementValue = String()
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil {
            elementValue! += string
            
            print(elementValue)
            if elementValue! == "1"
            {
            DispatchQueue.main.async {
                var oKaction:Int=0
                UserDefaults.standard.set(oKaction, forKey: "oKaction")
                var messageDescription="""
    Your password changed successfully!
    Thank you.......
    """
                UserDefaults.standard.set(messageDescription, forKey: "messageDescription")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewController(withIdentifier: "popUp") as! UIViewController
                self.present(vc, animated: true, completion: nil)
            }
            }
            else
            {
                DispatchQueue.main.async {
                    var oKaction:Int=0
                    UserDefaults.standard.set(oKaction, forKey: "oKaction")
                    var messageDescription="""
    Please check your old Password!
    Please try again,
    Thank you.........
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
        if elementName == "GetResetPasswordResult" {
            elementValue = String()
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    }
