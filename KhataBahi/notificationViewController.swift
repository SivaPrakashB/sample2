//
//  notificationViewController.swift
//  KhataBahi
//
//  Created by Narayan on 5/8/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit
import AnimatableReload

class notificationViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate {
    let abc=["a","a","a","a","a","a","a","a","a","a"]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dateList.count
    }
    var dateList=[String]()
    var messagesList=[String]()
    var result=String()
    @IBOutlet weak var tableView123: UITableView!
    var fnYear1=String()
    var dashBoardCompanyName123=String()
    var db_name=String()
    var serverUrl=String()
    
    var elementValue: String?
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
         var cell=tableView123.dequeueReusableCell(withIdentifier: "Cell") as! notificationTableViewCell
        cell.messageDescription.text=messagesList[indexPath.row]
        cell.date.text=dateList[indexPath.row]
        return cell
    }
    
    
   
    
    @IBOutlet weak var fnYear: UILabel!
    var imageView:UIImageView!
    @IBOutlet weak var companyName1: UILabel!
    var pdf123=String()
    var a=0
    var activityIndicator:UIActivityIndicatorView=UIActivityIndicatorView()
   
    
    
    @IBOutlet weak var notificationImage123: UIImageView!
    
    
    @IBOutlet weak var notificationViewPresent: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // tableView123.delegate=self
        //tableView123.dataSource=self
        notificationViewPresent.isHidden=false
        
        tableView123.separatorStyle = .none
        
     let jeremyGif = UIImage.gifImageWithName("abc1234")
        imageView = UIImageView(image: jeremyGif)
        
        imageView.frame = CGRect(x: (self.view.frame.size.width/2) - 40 , y: (self.view.frame.size.height/2)-40, width: 80, height: 80)
        self.view.addSubview(imageView)
     self.view.isUserInteractionEnabled=false
        
        
        /*    var width=(self.view.bounds.width/2)-40
         var height=(self.view.bounds.height/2)-40
         activityIndicator.frame=CGRect(x:width, y: height, width: 80, height: 80)
         activityIndicator.activityIndicatorViewStyle=UIActivityIndicatorViewStyle.whiteLarge
         activityIndicator.backgroundColor=UIColor.darkGray
         self.view.addSubview(activityIndicator)
         activityIndicator.startAnimating()
         activityIndicator.hidesWhenStopped=true*/
        /*  pdf123
         =  UserDefaults.standard.object(forKey: "urlForWebView") as! String
         print(pdf123,"bvspRock")
         */
        // pdf123=pdf123.addingPercentEncoding(withAllowedCharacters:CharacterSet.urlQueryAllowed)!
        
        /*    let url=NSURL(string:pdf123) as! URL
         
         
         let req=NSURLRequest(url: url as! URL)
         
         
         webView2.loadRequest(req as URLRequest)*/
    }
    override func viewDidAppear(_ animated: Bool) {
        
     fnYear1=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        dashBoardCompanyName123=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        
        
        companyName1.text=dashBoardCompanyName123
        fnYear.text="(\(fnYear1))"
       db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        serverUrl=UserDefaults.standard.object(forKey: "server_url") as! String
        getNotificationMessage()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func getNotificationMessage()
    {
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetNotificationMessage xmlns=\"http://tempuri.org/\"><CompanyName>\(dashBoardCompanyName123)</CompanyName><DB>\(db_name)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetNotificationMessage></soap:Body></soap:Envelope>"
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
        lobj_Request.addValue("http://tempuri.org/GetNotificationMessage", forHTTPHeaderField: "SOAPAction")
        
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
            print("456\(self.result)")
            if self.result != "0"
            {
                var dummyList=self.result.components(separatedBy: "^")
                for value in dummyList
                {
                    var secondDummyList=value.components(separatedBy: "~")
                    if secondDummyList.count == 2
                    {
                        self.dateList.append(secondDummyList[1])
                        self.messagesList.append(secondDummyList[0])
                    }
                }
                DispatchQueue.main.async {
                    self.imageView.isHidden=true
                    self.view.isUserInteractionEnabled=true
                    self.notificationViewPresent.isHidden=false
                    //self.tableView123.reloadData()
                     AnimatableReload.reload(tableView: self.tableView123, animationDirection: "left")
                }
                
            }
            else
            {
                DispatchQueue.main.async {
                    self.view.isUserInteractionEnabled=true
                    self.imageView.isHidden=true
                    self.notificationViewPresent.isHidden=true
                    self.tableView123.reloadData()
                }
            }
        })
        task.resume()
        
    }
   
    
    @IBOutlet weak var dismiss: UIButton!
    
    @IBAction func dismissView(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetNotificationMessageResult" {
            elementValue = String()
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil {
            elementValue! = elementValue!+string
           result=elementValue!
         print(123)
            
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetNotificationMessageResult" {
            elementValue = String()
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    
    
    
    
    
    
}
