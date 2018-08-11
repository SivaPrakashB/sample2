//
//  byListShowViewController.swift
//  KhataBahi
//
//  Created by Narayan on 5/15/18.
//  Copyright © 2018 senovTech. All rights reserved.
//

import UIKit

class byListShowViewController: UIViewController,XMLParserDelegate,UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate {
    var selection=0
    var server_url=String()
    var db_name=String()
    var dashBoardCompanyName=String()
    var dashBoardElementValueForFn=String()
    var cashId=[String]()
    var cashNames=[String]()
    var cashAmounts=[String]()
    var cashStatus=String()
    var searchResults=[String]()
    var paymentCondition=Int()
    override func viewDidLoad() {
        super.viewDidLoad()
    // tableView.separatorStyle = .none
        cashNameSearch.becomeFirstResponder()
        cashNameSearch.delegate=self
        cashNameSearch.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        // Do any additional setup after loading the view.
        
        dashBoardElementValueForFn=UserDefaults.standard.object(forKey: "dashBoardElementValueForFn") as! String
        
        /////barChartSetup
       
        dashBoardCompanyName=UserDefaults.standard.object(forKey: "dashBoardCompanyName") as! String
        server_url=UserDefaults.standard.object(forKey: "server_url") as! String
        db_name=UserDefaults.standard.object(forKey: "db_name") as! String
        
        
      
        
    }
    override func viewWillAppear(_ animated: Bool) {
        paymentCondition=UserDefaults.standard.object(forKey: "CashPaymentCondition") as! Int
        if paymentCondition==0
        {selection=0
              GetLedgersCASH()
        }
        else if paymentCondition==1
        {selection=0
            GetLedgersCASH()
        }
        else if paymentCondition==2
        {selection=1
           GetLedgersBank()
        }
        else if paymentCondition==3
        {selection=1
           GetLedgersBank()
        }
        else if paymentCondition==4
        {selection=0
             GetLedgersCASH()
        }
        else if paymentCondition==5
        {selection=0
            GetLedgersCASH()
        }
        else if paymentCondition==6
        {
            GetLedgersCASH()
            GetLedgersBank()
        }
        else if paymentCondition==7
        {
            GetLedgersCASH()
            GetLedgersBank()
        }
        else{
            
        }
      
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var cashNameSearch: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func close(_ sender: UIButton) {
        if paymentCondition==0
        {
       // dismiss(animated: true, completion: nil)
     let st=UIStoryboard(name: "Main", bundle: nil)
        let vc=st.instantiateViewController(withIdentifier: "cashPayment") as! UIViewController
        UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==1
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "cashReceipt") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==2
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Bank Statement") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==3
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Bank Receive") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==4
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Cash Bank Withdraw") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==5
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Cash Bank Deposit") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==6
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Contra Voucher") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==7
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Journal Voucher") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else{
            
        }
    }
    
    func GetLedgersCASH()
    {selection=0
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLedgersCASH xmlns=\"http://tempuri.org/\"><CompanyName>\(dashBoardCompanyName)</CompanyName><DB>\(db_name)</DB><FnYear>\(dashBoardElementValueForFn)</FnYear><SecurityKey>KBRE@#4321</SecurityKey></GetLedgersCASH></soap:Body></soap:Envelope>"
        print(is_SoapMessage,"getGraphdataBvsp")
        let is_URL: String = server_url+"WSKhataBahiOnline.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=server_url.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetLedgersCASH", forHTTPHeaderField: "SOAPAction")
        
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
                var dummyList=self.GetLedgersCASHResult.components(separatedBy: "^")
                for value in dummyList
                {
                 var dummyList1=value.components(separatedBy: "~")
                if dummyList1.count == 4
                {
                    self.cashId.append(dummyList1[0])
                    self.cashNames.append(dummyList1[1])
                    if dummyList1[2]==""
                    {
                    self.cashAmounts.append("0.00")
                    }
                    else
                    {
                        self.cashAmounts.append(dummyList1[2])
                    }
                    self.cashStatus=dummyList1[3]
                    self.searchResults=self.cashNames
                    self.tableView.isHidden=false
                    self.tableView.reloadData()
                }
                }
            }
        })
        task.resume()
        
    }
    func GetLedgersBank()
    {selection=1
        var is_SoapMessage: String = "<soap:Envelope xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance/\" xmlns:xsd=\"http://www.w3.org/2001/XMLSchema/\" xmlns:soap=\"http://schemas.xmlsoap.org/soap/envelope/\"><soap:Body><GetLedgersBANK xmlns=\"http://tempuri.org/\"><CompanyName>\(dashBoardCompanyName)</CompanyName><DB>\(db_name)</DB><FnYear>\(dashBoardElementValueForFn)</FnYear><SecurityKey>KBRE@#4321</SecurityKey></GetLedgersBANK></soap:Body></soap:Envelope>"
        print(is_SoapMessage,"getGraphdataBvsp")
        let is_URL: String = server_url+"WSKhataBahiOnline.asmx"
        
        let lobj_Request = NSMutableURLRequest(url: NSURL(string: is_URL)! as URL)
        let session = URLSession.shared
        //let err: NSError?
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        var hosturlList=server_url.components(separatedBy: "//")
        var hosturlList1=hosturlList[1]
        var hosturlList2=hosturlList1.components(separatedBy: "/")
        var hosturlFinal:String=hosturlList2[0]
        lobj_Request.addValue("\(hosturlFinal)", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.characters.count), forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://tempuri.org/GetLedgersBANK", forHTTPHeaderField: "SOAPAction")
        
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
                var dummyList=self.GetLedgersCASHResult.components(separatedBy: "^")
                for value in dummyList
                {
                    var dummyList1=value.components(separatedBy: "~")
                    if dummyList1.count == 4
                    {
                        self.cashId.append(dummyList1[0])
                        self.cashNames.append(dummyList1[1])
                        if dummyList1[2]==""
                        {
                            self.cashAmounts.append("0.00")
                        }
                        else
                        {
                            self.cashAmounts.append(dummyList1[2])
                        }
                        self.cashStatus=dummyList1[3]
                        self.searchResults=self.cashNames
                        self.tableView.isHidden=false
                        self.tableView.reloadData()
                    }
                }
            }
        })
        task.resume()
        
    }
    
    var elementValue: String?
    var GetLedgersCASHResult=String()
    var success = false
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        if elementName == "GetLedgersCASHResult" {
            elementValue = String()
            
        }
        if elementName == "GetLedgersBANKResult" {
            elementValue = String()
            
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        if elementValue != nil && selection==0{
            elementValue! += string
            GetLedgersCASHResult=elementValue!
            
            
        }
        if elementValue != nil  && selection==1{
            elementValue! += string
            GetLedgersCASHResult=elementValue!
            
            
        }
    }
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if elementName == "GetLedgersCASHResult" {
            elementValue = String()
        }
        if elementName == "GetLedgersBANKResult" {
            elementValue = String()
        }
    }
    
    func parser(_ parser: XMLParser, parseErrorOccurred parseError: Error) {
        print("parseErrorOccurred: \(parseError)")
    }
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        searchResults=cashNames
        tableView.reloadData()
        tableView.isHidden=false
        
        
        return true
    }
    /* func textFieldDidBeginEditing(_ textField: UITextField) {
     searchResults=names
     tableView.isHidden=false
     tableView.reloadData()
     }*/
    
   
    @objc func textFieldDidChange(_:UITextField){
        
        
       // print(customername.text!)
        
        
        // tableView.isHidden=false
        searchResults=[]
        
        
        searchResults = cashNames.filter({(coisas1:String) -> Bool in
            if (coisas1.lowercased()).contains(cashNameSearch.text!) || (coisas1.contains(cashNameSearch.text!))
            {
                //var asc=customername.text!.characters.prefix(0)
                //let stringMatch=coisas1.customMirror
                return true
            }
            else
            {
                
                return false
            }
            
            
        })
        /* print(dummysearchResults)
         for value in dummysearchResults
         {
         print(value)
         var count=customername.text?.count
         
         var firstLetter=String(value.suffix(count!))
         print(firstLetter)
         print(customername.text!)
         if firstLetter == customername.text
         {
         searchResults.append(value)
         tableView.reloadData()
         tableView.isHidden=false
         }
         }
         
         //
         //tableView.reloadData()
         // customername.resignFirstResponder()*/
        if cashNameSearch.text! == nil || cashNameSearch.text! == "" || cashNameSearch.text!.isEmpty==true
        {
            searchResults=cashNames
            tableView.reloadData()
        }
        else
        {
            tableView.reloadData()
            tableView.isHidden=false
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text=searchResults[indexPath.row]
        
        return cell!
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell=tableView.cellForRow(at: indexPath) as! UITableViewCell
        let label:String=(cell.textLabel?.text)!
        UserDefaults.standard.set(label, forKey: "byValue")
        for i in 0..<cashNames.count
        {
            if cashNames[i] == label
            {
                 UserDefaults.standard.set(self.cashAmounts[i], forKey: "byAmount")
                 UserDefaults.standard.set(self.cashId[i], forKey: "ByID")
            }
        }
       
        if paymentCondition==0
        {
            // dismiss(animated: true, completion: nil)
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "cashPayment") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==1
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "cashReceipt") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==2
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Bank Statement") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==3
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Bank Receive") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==4
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Cash Bank Withdraw") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==5
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Cash Bank Deposit") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==6
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Contra Voucher") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else if paymentCondition==7
        {
            let st=UIStoryboard(name: "Main", bundle: nil)
            let vc=st.instantiateViewController(withIdentifier: "Journal Voucher") as! UIViewController
            UIApplication.topViewController()?.present(vc, animated: true, completion: nil)
        }
        else{
            
        }
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        cashNameSearch.resignFirstResponder()
        return true
    }
}
