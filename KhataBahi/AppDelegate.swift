
//  AppDelegate.swift
//  KhataBahi
//  Created by Narayan on 3/26/18.
//  Copyright © 2018 senovTech. All rights reserved.


import UIKit

@UIApplicationMain
class AppDelegate: UIResponder,UIApplicationDelegate,XMLParserDelegate,UITextFieldDelegate{

    var window: UIWindow?
    var projectName:String="KhataBahi Android"
    var securityKey:String="#111000$"
    var version:Double=2.0
/* var is_SoapMessage: String = "<soapenv:Envelope xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:cgs=\"http://www.cgsapi.com/\"><soapenv:Header/><soapenv:Body><cgs:GetSystemStatus/></soapenv:Body></soapenv:Envelope>"*/
   
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
   
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
           
          if UserDefaults.standard.object(forKey: "DownCount") == nil
          {
              UserDefaults.standard.set(0, forKey: "DownCount")
              downLoadCount()
           
            }
            abc()
        } else {
            print("Internet connection FAILED")
            let alert = UIAlertView(title: "No Internet Connection", message: "Make sure your device is connected to the internet.", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }
        sleep(2)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


// Swift3 I fixed the problem using the code below:


    // Do any additional setup after loading the view, typically from a nib.
  func downLoadCount()
  {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><UserInstCount xmlns=\"http://tempuri.org/\"><DeviceType>IOS</DeviceType><SecurityKey>#111000$</SecurityKey></UserInstCount></soap:Body></soap:Envelope>"
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
    lobj_Request.addValue("http://tempuri.org/UserInstCount", forHTTPHeaderField: "SOAPAction")
    
    let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in
        print("Response: \(response)")
        if data != nil
        {
        let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
        print("Body: \(strData)")
     
        let XMLparser = XMLParser(data: data!)
        XMLparser.delegate = self
        XMLparser.parse()
        //XMLparser.shouldResolveExternalEntities = true
        }
        if error != nil
        {
            print("Error: " + error!.localizedDescription)
        }
        
    })
    task.resume()
    
}
    func abc()
    {var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetUpdatedVersion xmlns=\"http://tempuri.org/\"><ProjectName>KhataBahi IOS</ProjectName><SecurityKey>#111000$</SecurityKey></GetUpdatedVersion></soap:Body></soap:Envelope>"
        let is_URL: String = "http://admin.khatabahi.com/KhataBahiService.asmx"
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("admin.khatabahi.com", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetUpdatedVersion", forHTTPHeaderField: "SOAPAction")
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
    
    var elementValue: String?
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetUpdatedVersionResult" {
            elementValue = String()
        }
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil {
            elementValue! += string
            UserDefaults.standard.set(elementValue, forKey: "UpdatedVersion")
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetUpdatedVersionResult" {
            elementValue = String()
        }
    }
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
         print("parseErrorOccurred: \(parseError)")
    }
    
}
