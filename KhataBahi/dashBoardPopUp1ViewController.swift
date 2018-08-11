//
//  dashBoardPopUp1ViewController.swift
//  KhataBahi
//
//  Created by Narayan on 3/31/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class dashBoardPopUp1ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,XMLParserDelegate {
    var companyNames=[String]()
    var company_names=[String]()
    var server_url:String!
    var company_name:String!
    var db_name:String!
    var elementValueForFn:String?
    @IBOutlet weak var tableView1: UITableView!
    @IBOutlet weak var selectCompanyName: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView1.isHidden=true
        selectCompanyName.layer.borderWidth=2
        selectCompanyName.layer.borderColor=UIColor.black.cgColor
        companyNames=UserDefaults.standard.object(forKey: "company_names") as! [String]
        tableView1.isHidden=true
        selectCompanyName.setTitle("\(companyNames[0])", for: .normal)
        server_url=UserDefaults.standard.object(forKey: "server_url") as! String
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    @IBAction func selectCompanyName(_ sender: Any) { tableView1.delegate=self
        tableView1.dataSource=self
        if tableView1.isHidden == true
        {
            tableView1.isHidden=false
            
        }
        else{
            tableView1.isHidden=true
        }
        
        
    }
    
   
    @IBAction func okAction(_ sender: UIButton) {
        var company_name=selectCompanyName.titleLabel?.text
        print(company_name,"bvsp Company Name")
        UserDefaults.standard.set(company_name, forKey: "dashBoardCompanyName")
       gettitngFinancialYear()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyNames.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView1.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text="\(companyNames[indexPath.row])"
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectCompanyName.setTitle("\(companyNames[indexPath.row])", for: .normal)
        tableView1.isHidden=true
    }
    
    func gettitngFinancialYear()
    {company_name=selectCompanyName.titleLabel?.text
        print(company_name,"bvsp Company Name")
        UserDefaults.standard.set(company_name, forKey: "dashBoardCompanyName")
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetFnYear xmlns=\"http://tempuri.org/\"><CompanyName>\(company_name!)</CompanyName><DB>\(db_name!)</DB><SecurityKey>KBRE@#4321</SecurityKey></GetFnYear></soap:Body></soap:Envelope>"
        
        print(is_SoapMessage)
        
        let is_URL: String = server_url+"WSKhataBahiOnline.asmx"
        var hosturlList=server_url.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        ////http://wservice.khatabahi.online/ /////////
        print(is_URL)
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
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetFnYearResult"
        {
            elementValueForFn=String()
        }
        
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValueForFn != nil
        {
            elementValueForFn! += string
            print(elementValueForFn,"bvsp fn")
            var fnlist=elementValueForFn?.components(separatedBy: "^")
            print(fnlist,"bvsprock1")
            if fnlist!.count>1
            {
                var fn=fnlist![0]
                UserDefaults.standard.set(fn, forKey: "dashBoardElementValueForFn")
                UserDefaults.standard.set(fnlist!, forKey: "fnlist")
                DispatchQueue.main.async {
                  
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "dashBoard")
                    self.present(vc, animated: true, completion: nil)
                }
                
                
            }
            else if fnlist!.count==1
            {
                UserDefaults.standard.set(elementValueForFn!, forKey: "dashBoardElementValueForFn")
                  UserDefaults.standard.set(nil, forKey: "fnlist")
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "dashBoard")
                    self.present(vc, animated: true, completion: nil)
                }
            }
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetFnYearResult"
        {
            elementValueForFn=String()
        }
    }
    
}
